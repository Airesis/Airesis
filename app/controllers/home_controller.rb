#encoding: utf-8
#Copyright 2012 Rodi Alessandro
#This file is part of Airesis.
#Airesis is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as 
#published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
#Airesis is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY 
#or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#You should have received a copy of the GNU General Public License along with Foobar. If not, see http://www.gnu.org/licenses/.

class HomeController < ApplicationController
  include StepHelper
  layout :choose_layout
  
  #l'utente deve aver fatto login
  before_filter :authenticate_user!, :only => [:show]
  
  def index
    if (current_user)
      redirect_to home_url
    end
  end

  def engage
  end
    
  def show
    @step = get_next_step(current_user)
    @user = current_user
    @page_title = @user.fullname
  end
   
  private

  def choose_layout    
    if [ 'show'].include? action_name
      'users'
    else
      if [ 'engage'].include? action_name
        'landing'
      else
        nil
      end
    end
  end 
end
