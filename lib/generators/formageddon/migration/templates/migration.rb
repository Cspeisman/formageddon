class CreateFormageddonTables < ActiveRecord::Migration
  def self.up
    create_table :formageddon_contact_steps do |t|
      t.integer :formageddon_recipient_id
      t.string :formageddon_recipient_type
      t.integer :step_number
      t.string :command

      t.timestamps
    end

    create_table :formageddon_forms do |t|
      t.integer :formageddon_contact_step_id
      t.integer :form_number
      t.string :submit_css_selector
      t.boolean :use_field_names
      t.boolean :use_real_email_address, :default => false
      t.string :success_string

      t.timestamps
    end

    create_table :formageddon_form_fields do |t|
      t.integer :formageddon_form_id
      t.integer :field_number
      t.string :css_selector
      t.string :name
      t.string :value
      t.boolean :required

      t.timestamps
    end

    create_table :formageddon_form_captcha_images do |t|
      t.integer :formageddon_form_id
      t.integer :formageddon_recaptcha_form_id
      t.integer :image_number
      t.string :css_selector

      t.timestamps
    end

    create_table :formageddon_recaptcha_form do |t|
      t.integer :formageddon_form_id
      t.string :url
      t.string :response_field_css_selector
      t.string :image_css_selector
      t.string :id_selector

      t.timestamps
    end

    create_table :formageddon_threads do |t|
      t.integer :formageddon_recipient_id
      t.string :formageddon_recipient_type

      t.string :sender_title
      t.string :sender_first_name
      t.string :sender_last_name
      t.string :sender_address1
      t.string :sender_address2
      t.string :sender_city
      t.string :sender_state
      t.string :sender_zip5
      t.string :sender_zip4
      t.string :sender_phone
      t.string :sender_email
      t.string :privacy
      t.boolean :open, :default => true

      t.integer :formageddon_sender_id
      t.string :formageddon_sender_type

      t.timestamps
    end

    create_table :formageddon_letters do |t|
      t.integer :formageddon_thread_id
      t.string :direction
      t.text :status
      t.string :issue_area
      t.string :subject
      t.text :message

      t.timestamps
    end

    create_table :formageddon_delivery_attempts do |t|
      t.integer :formageddon_letter_id
      t.text :result
      t.integer :letter_contact_step
      t.text :before_browser_state_id
      t.text :after_browser_state_id
      t.text :captcha_browser_state_id

      t.timestamps
    end

    create_table :formageddon_browser_states do |t|
      t.text :uri
      t.text :cookie_jar
      t.text :raw_html

      t.timestamps
    end
  end

  def self.down
    drop_table :formageddon_contact_steps
    drop_table :formageddon_forms
    drop_table :formageddon_form_fields
    drop_table :formageddon_form_captcha_images
    drop_table :formageddon_threads
    drop_table :formageddon_letters
    drop_table :formageddon_delivery_attempts
    drop_table :formageddon_browser_states
  end
end
