# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121024100133) do

  create_table "action_abilitations", :force => true do |t|
    t.integer  "group_action_id"
    t.integer  "partecipation_role_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authentications", :force => true do |t|
    t.integer "user_id",                 :null => false
    t.string  "provider"
    t.string  "token"
    t.string  "uid",      :limit => 100
  end

  create_table "blocked_alerts", :force => true do |t|
    t.integer "notification_type_id"
    t.integer "user_id"
  end

  create_table "blog_comments", :force => true do |t|
    t.integer  "parent_blog_comment_id"
    t.integer  "blog_post_id"
    t.integer  "user_id"
    t.string   "user_ip"
    t.string   "user_agent"
    t.string   "referrer"
    t.string   "name"
    t.string   "site_url"
    t.string   "email"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blog_entries", :force => true do |t|
    t.integer "blog_id"
  end

  create_table "blog_post_images", :force => true do |t|
    t.integer "blog_post_id", :null => false
    t.integer "image_id",     :null => false
  end

  add_index "blog_post_images", ["blog_post_id", "image_id"], :name => "Constraint0", :unique => true

  create_table "blog_post_tags", :force => true do |t|
    t.integer "blog_post_id"
    t.integer "tag_id",       :null => false
  end

  add_index "blog_post_tags", ["blog_post_id", "tag_id"], :name => "index_blog_post_tags_on_blog_post_id_and_tag_id", :unique => true

  create_table "blog_posts", :force => true do |t|
    t.integer  "blog_id"
    t.string   "title",                           :null => false
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "published",    :default => false, :null => false
    t.datetime "published_at"
    t.integer  "user_id"
  end

  create_table "blog_tags", :force => true do |t|
    t.integer "blog_id"
    t.integer "tag_id",  :null => false
  end

  add_index "blog_tags", ["blog_id", "tag_id"], :name => "index_blog_tags_on_blog_id_and_tag_id", :unique => true

  create_table "blogs", :force => true do |t|
    t.integer "user_id"
    t.string  "title"
  end

  create_table "candidates", :force => true do |t|
    t.integer  "user_id",     :null => false
    t.integer  "election_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "score"
  end

  add_index "candidates", ["user_id", "election_id"], :name => "index_candidates_on_user_id_and_election_id", :unique => true

  create_table "circoscriziones", :force => true do |t|
    t.integer "comune_id"
    t.string  "description", :limit => 100
  end

  create_table "circoscrizioni_groups", :id => false, :force => true do |t|
    t.integer "id",                                                  :null => false
    t.string  "name",               :limit => 200
    t.string  "description",        :limit => 2000
    t.string  "accept_requests",    :limit => 1,    :default => "v", :null => false
    t.integer "interest_border_id"
    t.integer "circoscrizione_id"
    t.string  "facebook_page_url"
    t.integer "image_id"
    t.string  "title_bar"
    t.string  "image_url"
  end

  create_table "comunali_groups", :id => false, :force => true do |t|
    t.integer "id",                                                  :null => false
    t.string  "name",               :limit => 200
    t.string  "description",        :limit => 2000
    t.string  "accept_requests",    :limit => 1,    :default => "v", :null => false
    t.integer "interest_border_id"
    t.integer "comune_id"
    t.string  "facebook_page_url"
    t.integer "image_id"
    t.string  "title_bar"
    t.string  "image_url"
  end

  create_table "comunes", :force => true do |t|
    t.string  "description",  :limit => 100, :null => false
    t.integer "provincia_id",                :null => false
    t.integer "regione_id",                  :null => false
    t.integer "population"
    t.string  "codistat",     :limit => 4
    t.string  "cap",          :limit => 5
  end

  create_table "election_votes", :force => true do |t|
    t.integer  "user_id",     :null => false
    t.integer  "election_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "election_votes", ["user_id", "election_id"], :name => "index_election_votes_on_user_id_and_election_id", :unique => true

  create_table "elections", :force => true do |t|
    t.string   "name",                                   :null => false
    t.string   "description",                            :null => false
    t.integer  "event_id",                               :null => false
    t.datetime "groups_end_time",                        :null => false
    t.datetime "candidates_end_time",                    :null => false
    t.string   "status",              :default => "1",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "score_calculated",    :default => false
  end

  create_table "event_series", :force => true do |t|
    t.integer  "frequency",  :default => 1
    t.string   "period",     :default => "months"
    t.datetime "starttime"
    t.datetime "endtime"
    t.boolean  "all_day",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_types", :force => true do |t|
    t.string "description", :limit => 200
  end

  create_table "events", :force => true do |t|
    t.string   "title"
    t.datetime "starttime"
    t.datetime "endtime"
    t.boolean  "all_day",         :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.integer  "event_series_id"
    t.integer  "event_type_id"
    t.boolean  "private",         :default => false, :null => false
  end

  add_index "events", ["event_series_id"], :name => "index_events_on_event_series_id"

  create_table "group_actions", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "group_affinities", :force => true do |t|
    t.integer  "group_id",                       :null => false
    t.integer  "user_id",                        :null => false
    t.integer  "value"
    t.boolean  "recalculate", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "group_elections", :force => true do |t|
    t.integer  "group_id",    :null => false
    t.integer  "election_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "group_elections", ["group_id", "election_id"], :name => "index_group_elections_on_group_id_and_election_id", :unique => true

  create_table "group_follows", :force => true do |t|
    t.integer "user_id",  :null => false
    t.integer "group_id", :null => false
  end

  create_table "group_partecipation_request_statuses", :force => true do |t|
    t.string "description", :limit => 200, :null => false
  end

  create_table "group_partecipation_requests", :force => true do |t|
    t.integer "user_id",                                              :null => false
    t.integer "group_id",                                             :null => false
    t.integer "group_partecipation_request_status_id", :default => 1, :null => false
  end

  add_index "group_partecipation_requests", ["user_id", "group_id"], :name => "unique", :unique => true

  create_table "group_partecipations", :force => true do |t|
    t.integer "user_id",                              :null => false
    t.integer "group_id",                             :null => false
    t.integer "partecipation_role_id", :default => 1, :null => false
  end

  add_index "group_partecipations", ["user_id", "group_id"], :name => "only_once_per_group", :unique => true

  create_table "group_proposals", :force => true do |t|
    t.integer  "proposal_id", :null => false
    t.integer  "group_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "group_proposals", ["proposal_id", "group_id"], :name => "index_group_proposals_on_proposal_id_and_group_id", :unique => true

  create_table "groups", :force => true do |t|
    t.string  "name",                  :limit => 200
    t.string  "description",           :limit => 2000
    t.string  "accept_requests",       :limit => 1,    :default => "v", :null => false
    t.integer "interest_border_id"
    t.string  "facebook_page_url"
    t.integer "image_id"
    t.string  "title_bar"
    t.string  "image_url"
    t.integer "partecipation_role_id",                 :default => 1
  end

  create_table "images", :force => true do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "interest_borders", :force => true do |t|
    t.integer "territory_id",   :null => false
    t.string  "territory_type", :null => false
  end

  create_table "meeting_organizations", :force => true do |t|
    t.integer "group_id"
    t.integer "event_id"
  end

  create_table "meeting_partecipations", :force => true do |t|
    t.integer "user_id"
    t.integer "meeting_id"
    t.string  "comment"
    t.integer "guests",                  :default => 0, :null => false
    t.string  "response",   :limit => 1
  end

  create_table "meetings", :force => true do |t|
    t.integer "place_id"
    t.integer "event_id"
  end

  create_table "notification_categories", :force => true do |t|
    t.string "description"
  end

  create_table "notification_types", :force => true do |t|
    t.string  "description",              :null => false
    t.integer "notification_category_id", :null => false
  end

  create_table "notifications", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "notification_type_id",                 :null => false
    t.string   "message",              :limit => 1000
    t.string   "url"
  end

  create_table "partecipation_roles", :force => true do |t|
    t.integer "parent_partecipation_role_id"
    t.integer "group_id"
    t.string  "name",                         :limit => 200
    t.string  "description",                  :limit => 2000
  end

  create_table "periods", :force => true do |t|
    t.datetime "from", :null => false
    t.datetime "to",   :null => false
  end

  add_index "periods", ["from", "to"], :name => "from_to_unique", :unique => true

  create_table "places", :force => true do |t|
    t.integer "comune_id"
    t.string  "frazione",           :limit => 200
    t.string  "address",            :limit => 200
    t.string  "civic_number",       :limit => 10
    t.string  "cap",                :limit => 5
    t.float   "latitude_original"
    t.float   "longitude_original"
    t.float   "latitude_center"
    t.float   "longitude_center"
    t.integer "zoom"
  end

  create_table "post_publishings", :force => true do |t|
    t.integer "blog_post_id"
    t.integer "group_id"
  end

  create_table "proposal_borders", :force => true do |t|
    t.integer "proposal_id",        :null => false
    t.integer "interest_border_id", :null => false
    t.integer "created_at"
  end

  add_index "proposal_borders", ["proposal_id"], :name => "_idx_proposal_borderds_proposal_id"

  create_table "proposal_categories", :force => true do |t|
    t.integer "parent_proposal_category_id"
    t.string  "description",                 :limit => 200
  end

  create_table "proposal_comment_rankings", :force => true do |t|
    t.integer  "proposal_comment_id", :null => false
    t.integer  "user_id",             :null => false
    t.integer  "ranking_type_id",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "proposal_comment_rankings", ["proposal_comment_id", "user_id"], :name => "user_comment", :unique => true

  create_table "proposal_comments", :force => true do |t|
    t.integer  "parent_proposal_comment_id"
    t.integer  "user_id"
    t.integer  "proposal_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_ip"
    t.string   "user_agent"
    t.string   "referrer"
    t.boolean  "deleted",                                    :default => false, :null => false
    t.integer  "deleted_user_id"
    t.datetime "deleted_at"
    t.string   "content",                    :limit => 2000
    t.integer  "rank",                                       :default => 0,     :null => false
    t.integer  "valutations",                                :default => 0,     :null => false
  end

  create_table "proposal_histories", :force => true do |t|
    t.integer  "proposal_id",                  :null => false
    t.integer  "user_id",                      :null => false
    t.string   "content",     :limit => 20000, :null => false
    t.string   "problem",     :limit => 20000
    t.integer  "valutations",                  :null => false
    t.integer  "rank",                         :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "proposal_nicknames", :force => true do |t|
    t.integer  "proposal_id", :null => false
    t.integer  "user_id",     :null => false
    t.string   "nickname",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "proposal_nicknames", ["nickname"], :name => "index_proposal_nicknames_on_nickname"
  add_index "proposal_nicknames", ["proposal_id", "nickname"], :name => "index_proposal_nicknames_on_proposal_id_and_nickname", :unique => true
  add_index "proposal_nicknames", ["proposal_id", "user_id"], :name => "index_proposal_nicknames_on_proposal_id_and_user_id", :unique => true

  create_table "proposal_presentations", :force => true do |t|
    t.integer  "proposal_id", :null => false
    t.integer  "user_id",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "proposal_presentations", ["proposal_id"], :name => "_idx_proposal_presentations_proposal_id"
  add_index "proposal_presentations", ["user_id"], :name => "_idx_proposal_presentations_user_id"

  create_table "proposal_rankings", :force => true do |t|
    t.integer  "proposal_id"
    t.integer  "user_id"
    t.integer  "ranking_type_id"
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  add_index "proposal_rankings", ["proposal_id", "user_id"], :name => "proposal_user", :unique => true

  create_table "proposal_states", :force => true do |t|
    t.string "description", :limit => 200
  end

  create_table "proposal_supports", :force => true do |t|
    t.integer  "proposal_id", :null => false
    t.integer  "group_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "proposal_tags", :force => true do |t|
    t.integer  "proposal_id", :null => false
    t.integer  "tag_id",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "proposal_tags", ["proposal_id", "tag_id"], :name => "index_proposal_tags_on_proposal_id_and_tag_id", :unique => true

  create_table "proposal_votes", :force => true do |t|
    t.integer  "proposal_id", :limit => 8
    t.integer  "positive"
    t.integer  "negative"
    t.integer  "neutral"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "proposal_watches", :force => true do |t|
    t.integer  "user_id"
    t.integer  "proposal_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "proposals", :force => true do |t|
    t.integer  "proposal_state_id"
    t.integer  "proposal_category_id",                     :default => 5,     :null => false
    t.string   "title",                   :limit => 200,                      :null => false
    t.string   "content",                 :limit => 20000
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "valutations",                              :default => 0
    t.integer  "vote_period_id"
    t.integer  "proposal_comments_count",                  :default => 0
    t.integer  "rank",                                     :default => 0,     :null => false
    t.string   "problem",                 :limit => 20000
    t.string   "subtitle",                                 :default => "",    :null => false
    t.string   "problems",                :limit => 18000, :default => "",    :null => false
    t.string   "objectives",              :limit => 18000, :default => "",    :null => false
    t.boolean  "show_comment_authors",                     :default => true,  :null => false
    t.boolean  "private",                                  :default => false, :null => false
  end

  add_index "proposals", ["proposal_category_id"], :name => "_idx_proposals_proposal_category_id"
  add_index "proposals", ["proposal_state_id"], :name => "_idx_proposals_proposal_state_id"
  add_index "proposals", ["vote_period_id"], :name => "_idx_proposals_vote_period_id"

  create_table "provas", :force => true do |t|
    t.string   "testo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "provinciali_groups", :id => false, :force => true do |t|
    t.integer "id",                                                  :null => false
    t.string  "name",               :limit => 200
    t.string  "description",        :limit => 2000
    t.string  "accept_requests",    :limit => 1,    :default => "v", :null => false
    t.integer "interest_border_id"
    t.integer "provincia_id"
    t.string  "facebook_page_url"
    t.integer "image_id"
    t.string  "title_bar"
    t.string  "image_url"
  end

  create_table "provincias", :force => true do |t|
    t.string  "description", :limit => 100
    t.integer "regione_id",                 :null => false
    t.string  "sigla",       :limit => 5
  end

  create_table "ranking_types", :force => true do |t|
    t.string "description", :limit => 200, :null => false
  end

  create_table "regionali_groups", :id => false, :force => true do |t|
    t.integer "id",                                                  :null => false
    t.string  "name",               :limit => 200
    t.string  "description",        :limit => 2000
    t.string  "accept_requests",    :limit => 1,    :default => "v", :null => false
    t.integer "interest_border_id"
    t.integer "regione_id"
    t.string  "facebook_page_url"
    t.integer "image_id"
    t.string  "title_bar"
    t.string  "image_url"
  end

  create_table "regiones", :force => true do |t|
    t.string "description", :limit => 100
  end

  create_table "request_vote_types", :force => true do |t|
    t.string "description", :limit => 10, :null => false
  end

  create_table "request_votes", :force => true do |t|
    t.integer "group_partecipation_request_id",                :null => false
    t.integer "user_id",                                       :null => false
    t.integer "request_vote_type_id",                          :null => false
    t.string  "comment",                        :limit => 200
  end

  create_table "schulze_votes", :force => true do |t|
    t.integer  "election_id",                :null => false
    t.string   "preferences",                :null => false
    t.integer  "count",       :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schulze_votes", ["election_id", "preferences"], :name => "index_schulze_votes_on_election_id_and_preferences", :unique => true

  create_table "simple_votes", :force => true do |t|
    t.integer  "candidate_id",                :null => false
    t.integer  "count",        :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "simple_votes", ["candidate_id"], :name => "index_simple_votes_on_candidate_id", :unique => true

  create_table "steps", :force => true do |t|
    t.integer  "tutorial_id",                    :null => false
    t.integer  "index",       :default => 0,     :null => false
    t.string   "title"
    t.text     "content"
    t.boolean  "required",    :default => false
    t.text     "fragment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "supporters", :force => true do |t|
    t.integer  "candidate_id", :null => false
    t.integer  "group_id",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "supporters", ["candidate_id", "group_id"], :name => "index_supporters_on_candidate_id_and_group_id", :unique => true

  create_table "tags", :force => true do |t|
    t.string   "text",                            :null => false
    t.integer  "proposals_count",  :default => 0, :null => false
    t.integer  "blog_posts_count", :default => 0, :null => false
    t.integer  "blogs_count",      :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["text"], :name => "index_tags_on_text", :unique => true

  create_table "testi_vari", :id => false, :force => true do |t|
    t.integer "id",                      :null => false
    t.string  "testo_a", :limit => 4000
    t.string  "testo_b", :limit => 4000
  end

  create_table "tutorial_assignees", :force => true do |t|
    t.integer  "user_id",                        :null => false
    t.integer  "tutorial_id",                    :null => false
    t.boolean  "completed",   :default => false, :null => false
    t.integer  "index",       :default => 0,     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tutorial_progresses", :force => true do |t|
    t.integer  "user_id",                     :null => false
    t.integer  "step_id",                     :null => false
    t.string   "status",     :default => "N", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tutorials", :force => true do |t|
    t.string   "action"
    t.string   "controller",  :null => false
    t.string   "name"
    t.text     "description", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_alerts", :force => true do |t|
    t.integer  "notification_id", :null => false
    t.integer  "user_id"
    t.boolean  "checked"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "checked_at"
  end

  create_table "user_borders", :force => true do |t|
    t.integer "user_id",            :null => false
    t.integer "interest_border_id", :null => false
    t.integer "created_at"
  end

  add_index "user_borders", ["user_id"], :name => "_idx_user_borders_user_id"

  create_table "user_follows", :force => true do |t|
    t.integer  "follower_id", :null => false
    t.integer  "followed_id", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "user_follows", ["follower_id", "followed_id"], :name => "user_follows_unique", :unique => true

  create_table "user_types", :force => true do |t|
    t.string "description", :limit => 200
    t.string "short_name"
  end

  add_index "user_types", ["short_name"], :name => "srt_name_unq", :unique => true

  create_table "user_votes", :force => true do |t|
    t.integer  "proposal_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_votes", ["proposal_id", "user_id"], :name => "onlyvoteuser", :unique => true

  create_table "users", :force => true do |t|
    t.integer  "user_type_id",                              :default => 3,     :null => false
    t.integer  "residenza_id"
    t.integer  "nascita_id"
    t.string   "name",                      :limit => 100
    t.string   "surname",                   :limit => 100
    t.string   "email",                     :limit => 100
    t.string   "sex",                       :limit => 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "login",                     :limit => 40
    t.string   "password_salt",             :limit => 40
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "deleted_at"
    t.string   "state"
    t.string   "reset_password_token"
    t.string   "encrypted_password",        :limit => 128,                     :null => false
    t.boolean  "activist",                                  :default => false, :null => false
    t.boolean  "elected",                                   :default => false, :null => false
    t.string   "blog_image_url",            :limit => 1000
    t.integer  "image_id"
    t.integer  "rank"
    t.integer  "fb_user_id"
    t.string   "email_hash"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "sign_in_count",                             :default => 0
    t.string   "account_type"
    t.datetime "remember_created_at"
    t.datetime "confirmation_sent_at"
    t.boolean  "banned",                                    :default => false, :null => false
    t.boolean  "email_alerts",                              :default => false, :null => false
    t.datetime "reset_password_sent_at"
  end

  add_index "users", ["email"], :name => "uniqueemail", :unique => true
  add_index "users", ["login"], :name => "uniquelogin", :unique => true

  add_foreign_key "groups", "partecipation_roles", :name => "groups_partecipation_role_id_fk"

end
