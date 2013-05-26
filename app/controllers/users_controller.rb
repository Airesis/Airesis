#encoding: utf-8
class UsersController < ApplicationController


  layout :choose_layout

  before_filter :authenticate_user!, :except => [:index, :show, :confirm_credentials, :join_accounts]
  # Protect these actions behind an admin login
  # before_filter :admin_required, :only => [:suspend, :unsuspend, :destroy, :purge]
  before_filter :find_user, :only => [:show, :suspend, :unsuspend, :destroy, :purge, :update, :update_image, :edit, :show_message, :send_message]

  def confirm_credentials
    @user = User.new_with_session(nil, session)
    @orig = User.find_by_email(@user.email)
  end

  #unisce due account
  def join_accounts
    data = session["devise.google_data"] || session["devise.facebook_data"] || session["devise.linkedin_data"] #prendi i dati di facebook dalla sessione
    email = ""
    if data["provider"] == Authentication::LINKEDIN
      email = data["extra"]["raw_info"]["emailAddress"]
    else
      email = data["extra"]["raw_info"]["email"]
    end
    if params[:user][:email] && (email != params[:user][:email]) #se per caso viene passato un indirizzo email differente
      flash[:error] = 'Dai va là!'
      redirect_to confirm_credentials_users_url
    else
      auth = User.find_by_email(email) #trova l'utente del portale con email e password indicati
      if (auth.valid_password?(params[:user][:password]) unless auth.nil?) #se la password fornita è corretta
                                                                           #aggiungi il provider
        User.transaction do
          auth.authentications.build(:provider => data['provider'], :uid => data['uid'], :token => (data['credentials']['token'] rescue nil))
          auth.save!
        end
        #fine dell'unione
        flash[:info] = t('controllers.users.join_accounts.ok_message')
        sign_in_and_redirect auth, :event => :authentication
      else
        flash[:error] = t('controllers.users.join_accounts.wrong_password')
        redirect_to confirm_credentials_users_url
      end
    end
  rescue Exception => e
    flash[:error] = t('controllers.users.ko_message')
    redirect_to confirm_credentials_users_url
  end

  def index
    return redirect_to root_path if user_signed_in?
    @users = User.all(:conditions => "upper(name) like upper('%#{params[:q]}%')")

    respond_to do |format|
      #format.xml  { render :xml => @users }
      format.json { render :json => @users.to_json(:only => [:id, :name]) }
      format.html # index.html.erb
    end
  end

  def show
    respond_to do |format|
      flash.now[:notice] = t('controllers.users.show.clic_to_change') if (current_user == @user)
      format.html # show.html.erb
                  #format.xml  { render :xml => @user }
    end
  end


  def alarm_preferences
    @user = current_user
    respond_to do |format|
      flash.now[:notice] = t('controllers.users.show.clic_to_change') if (current_user == @user)
      format.html # show.html.erb
                  #format.xml  { render :xml => @user }
    end
  end

  def border_preferences
    @user = current_user
  end

  def privacy_preferences
    @user = current_user
  end


  def change_show_tooltips
    current_user.show_tooltips = params[:active]
    current_user.save
    params[:active] == 'true' ?
        flash[:notice] = t('controllers.users.tooltips.enabled') :
        flash[:notice] = t('controllers.users.tooltips.disabled')

    respond_to do |format|
      format.js { render :update do |page|
        page.replace_html "flash_messages", :partial => 'layouts/flash', :locals => {:flash => flash}
      end
      }
    end

  rescue Exception => e
    respond_to do |format|
      flash[:error] = t('controllers.users.tooltips.ko_message')
      format.js { render :update do |page|
        page.replace_html "flash_messages", :partial => 'layouts/flash', :locals => {:flash => flash}
      end
      }
    end
  end

  def change_show_urls
    current_user.show_urls = params[:active]
    current_user.save
    params[:active] == 'true' ?
        flash[:notice] = t('controllers.users.urls.shown') :
        flash[:notice] = t('controllers.users.urls.hidden')

    respond_to do |format|
      format.js { render :update do |page|
        page.replace_html "flash_messages", :partial => 'layouts/flash', :locals => {:flash => flash}
      end
      }
    end

  rescue Exception => e
    respond_to do |format|
      flash[:error] = t('controllers.users.tooltips.ko_message')
      format.js { render :update do |page|
        page.replace_html "flash_messages", :partial => 'layouts/flash', :locals => {:flash => flash}
      end
      }
    end
  end

  def change_receive_messages
    current_user.receive_messages = params[:active]
    current_user.save
    if params[:active] == 'true'
      flash[:notice] = t('info.private_messages_active')
    else
      flash[:notice] = t('info.private_messages_inactive')
    end

    respond_to do |format|
      format.js { render :update do |page|
        page.replace_html "flash_messages", :partial => 'layouts/flash', :locals => {:flash => flash}
      end
      }
    end

  rescue Exception => e
    respond_to do |format|
      flash[:error] = t('controllers.users.tooltips.ko_message')
      format.js { render :update do |page|
        page.replace_html "flash_messages", :partial => 'layouts/flash', :locals => {:flash => flash}
      end
      }
    end
  end

  #aggiorni i confini di interesse dell'utente
  def set_interest_borders
    borders = params[:token][:interest_borders]
    #cancella i vecchi confini di interesse
    current_user.user_borders.each do |border|
      border.destroy
    end
    update_borders(borders)
    flash[:notice] = t('controllers.users.interest_borders.ok_message')
    AffinityHelper.calculate_group_affinity(current_user, Group.all)
    redirect_to :back
  end

  def update_image
    if params[:image]
      image = Image.new({:image => params[:image]})
      image.save!
      @user.image_id = image.id
      @user.save!
    end
    respond_to do |format|
      format.js do
        render :update do |page|
          page.replace_html "flash_messages", :partial => 'layouts/flash', :locals => {:flash => flash}
          page.replace_html "user_profile_container", :partial => "user_profile"
        end
      end
      format.html {
        if params[:back] == "home"
          redirect_to home_url
        else
          redirect_to @user
        end
      }
    end
  end

  def update
    respond_to do |format|

      if @user.update_attributes(params[:user])
        flash[:notice] = t(:user_updated)
        if params[:user][:email] && @user.email != params[:user][:email]
          flash[:notice] += t('controllers.users.update.confirm_email')
        end
        format.js do
          render :update do |page|
            page.replace_html "flash_messages", :partial => 'layouts/flash', :locals => {:flash => flash}
            page.replace_html "user_profile_container", :partial => "user_profile"
          end
        end
        format.html {
          if params[:back] == "home"
            redirect_to home_url
          else
            redirect_to @user
          end
        }
        format.xml { render :xml => @proposal }
      else
        @user.errors.full_messages.each do |msg|
          flash[:error] = msg
        end
        format.js do
          render :update do |page|
            page.replace_html "error_updating", :partial => 'layouts/flash', :locals => {:flash => flash}
          end
        end
        format.html {
          if params[:back] == "home"
            redirect_to home_url
          else
            render :action => "show"
          end
        }
        format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # There's no page here to update or destroy a user.  If you add those, be
  # smart -- make sure you check that the visitor is authorized to do so, that they
  # supply their old password along with a new one to update it, etc.

  #mostra la form di invio messaggio all'utente
  def show_message
    authorize! :send_message, @user

  end

  #invia un messaggio all'utente
  def send_message
    authorize! :send_message, @user
    ResqueMailer.user_message(params[:message][:subject], params[:message][:body], current_user.id, @user.id).deliver
    flash[:notice] = t('info.message_sent')
  end

  protected

  def choose_layout
    (['index'].include? action_name) ? 'settings' : 'users'
  end

  def find_user
    @user = User.find(params[:id])
  end

  def update_borders(borders)
    #confini di interesse, scorrili
    borders.split(',').each do |border| #l'identificativo è nella forma 'X-id'
      ftype = border[0, 1] #tipologia (primo carattere)
      fid = border[2..-1] #chiave primaria (dal terzo all'ultimo carattere)
      found = InterestBorder.table_element(border)

      if found #if I found something so the ID is correct and I can proceed with geographic border creation
        interest_b = InterestBorder.find_or_create_by_territory_type_and_territory_id(InterestBorder::I_TYPE_MAP[ftype], fid)
        i = current_user.user_borders.build({:interest_border_id => interest_b.id})
        i.save
      end
    end
  end
end
