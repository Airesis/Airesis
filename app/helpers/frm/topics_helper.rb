module Frm
  module TopicsHelper
    def link_to_latest_post(topic)
      post = relevant_posts(topic).last
      text = "#{time_ago_in_words(post.created_at)} #{t('by')} #{post.user}"
      link_to text, group_forum_topic_url(post.topic.forum.group, post.topic.forum, post.topic, anchor: "post-#{post.id}", page: topic.last_page)
    end

    def new_since_last_view_text(topic)
      return unless current_user

      forum_view = topic.forum.view_for(current_user)
      return unless forum_view

      topic_view = topic.view_for(current_user)
      return unless topic_view.nil? && topic.created_at > forum_view.past_viewed_at

      content_tag :super, 'New'
    end

    def relevant_posts(topic)
      posts = topic.posts.by_created_at
      if forem_admin_or_moderator?(topic.forum)
        posts
      elsif topic.user == current_user
        posts.visible(current_user).approved_or_pending_review_for(topic.user)
      else
        posts.approved
      end
    end

    def icon_classes(topic)
      classes = 'icon '
      classes += ' lock ' if topic.locked?
      classes += ' pin ' if topic.pinned?
      classes += ' hidden ' if topic.hidden?
      if current_user
        topic_view = topic.view_for(current_user)
        forum_view = topic.forum.view_for(current_user)
        if (topic_view && topic.last_post_at > topic_view.updated_at) ||
            (forum_view && topic.created_at > forum_view.updated_at)
          classes += ' new_posts '
        end
      end
      classes
    end
  end
end
