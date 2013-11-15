class CheckGroups
  include GroupsHelper, Rails.application.routes.url_helpers, ProposalsModule

  def self.perform(*args)
    Group.joins(:partecipants).where({status: 'active', certified: false}).where(['groups.created_at < ?', Time.now - 7.days]).group('groups.id').having('count(users.*) < 2').readonly(false).each do |group|
      GroupsMailer.few_users_a(group.id).deliver
      group.update_attribute(:status,Group::STATUS_FEW_USERS_A)
      group.update_attribute(:status_changed_at,Time.now)
    end
  end

end
