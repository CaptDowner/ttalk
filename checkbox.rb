Ruby syntax:

 <% (1..5).each do |chk| %>
         <%= check_box_tag('chk[]', chk) %>
         <%= chk %>
      <% end %>

Jquery Syntax:

$('document').ready(function(){
    $('input["name=chk[]"]').change(function(){
     if($(this).attr("checked")){
    alert($(this).val())}
  })
})

which gives alert of the checked check box 
value when you change checkbox.

if you want checked check box value when 
document loads then try this

$('document').ready(function(){
           alert($('input["name=chk[]"]:checked').val())
   })
--------------------------------------
Try with:

<% (1..5).each do |chk| %>
   <%= check_box_tag 'chk[]',"#{chk}", :checked=>false%>
<% end %>

Then, in the controller, params[:chk] will 
give you an array of check box values which 
are checked.
--------------------------------------

Checkbox list in Ruby on Rails using HABTM

Checkboxes are one of those things that look easy and 
should be easy, but they aren't always easy. I needed 
a solution that could create a checkbox list of languages 
that a user speaks. So I don't forget here's how to do it:

The migrations are important. You have to be sure to 
exclude the id parameter when you create languages_users 
or you will get ' Mysql::Error: #23000Duplicate entry' due 
to the fact that ActiveRecord will try to store a value in 
the id field that indicates which model created the entry 
(User.languages << vs Langauges.users). The other option is 
the create the id parameter so that the direction is maintained 
but be sure that it is not created as a primary key.

class LanguagesUsers < ActiveRecord::Migration
    def self.up
        create_table :languages_users, :id => false, :force => true do |t|
            t.integer :user_id
            t.integer :language_id
            t.timestamps
        end
    end

    def self.down
        drop_table :languages_users
    end
end

class Languages < ActiveRecord::Migration

    def self.up
        create_table "languages", :force => true do |t|
            t.string  "name"
            t.string  "english_name"
            t.integer "is_default", :default => 0
        end
    end

    def self.down
        drop_table "languages"
        drop_table "users_languages"
    end
end

class Users < ActiveRecord::Migration

    def self.up
        create_table "users", :force => true do |t|
            t.string  "login"
            # other fields excluded for brevity
        end
    end

    def self.down
        drop_table "users"
    end
end

Here are my models: user.rb

class User < ActiveRecord::Base
    has_and_belongs_to_many :languages
end

language.rb:

class Language < ActiveRecord::Base
  has_and_belongs_to_many :users
end

In my user_controller.rb the create and update methods are simple. 
This is thanks to the fact that you get a language_ids method on 
the user object because of the HABTM relationship.

    def create
        @user = User.new(params[:user])
        @user.save
    end

    def update
        params[:user][:language_ids] ||= []

        @user = User.find(current_user)
      
        if @user.update_attributes params[:user]
            flash[:notice] = "Settings have been saved."
            redirect_to edit_user_url(@user)
        else
            flash.now[:error] = @user.errors
            setup_form_values
            respond_to do |format|
                format.html { render :action => :edit}
            end
        end

    end

On to the view:

<ul class="checkbox-list">
  <% @languages.each do |language| -%>
<li><%= check_box_tag "user[language_ids][]", language.id, user_speaks_language?(language) -%> <%= language.english_name -%></li>
  <% end -%>
</ul>

NOTE: I had an error in my original method. This code:

<li><%= f.check_box :language_ids, {:checked => user_speaks_language?(language)}, "#{language.id}", ""  -%> <%= "#{language.english_name}" -%></li>

should be this:

<li><%= check_box_tag "user[language_ids][]", language.id, user_speaks_language?(language) -%> <%= language.english_name -%></li>

And we'll need this helper method:

def user_speaks_language?(language)
    if @user && !@user.login.nil? # no sense in testing new users that have no languages
        @user.languages.include?(language)
    else
        false
    end
end

The result is that you will get a list of check boxes that update 
values in the join table that is part of the has_and_belongs_to_many 
relationship. Rails is very cool
------------------------------------------------------------------
Stripping away all wrapper divs

Simple Form also allows you to strip away all the div wrappers 
around the <input> field that is generated with the usual f.input. 
The easiest way to achieve this is to use f.input_field.

Example:

simple_form_for @user do |f|
  f.input_field :name
  f.input_field :remember_me, as: :boolean
end

<form>
  ...
  <input class="string required" id="user_name" maxlength="255" name="user[name]" size="255" type="text">
  <input name="user[remember_me]" type="hidden" value="0">
  <label class="checkbox">
    <input class="boolean optional" id="user_published" name="user[remember_me]" type="checkbox" value="1">
  </label>
</form>

For check boxes and radio buttons you can remove the label changing 
boolean_style from default value :nested to :inline.

Example:

simple_form_for @user do |f|
  f.input_field :name
  f.input_field :remember_me, as: :boolean, boolean_style: :inline
end

<form>
  ...
  <input class="string required" id="user_name" maxlength="255" name="user[name]" size="255" type="text">
  <input name="user[remember_me]" type="hidden" value="0">
  <input class="boolean optional" id="user_remember_me" name="user[remember_me]" type="checkbox" value="1">
</form>

Produces:

<input class="string required" id="user_name" maxlength="100"
   name="user[name]" size="100" type="text" value="Carlos" />

To view the actual RDocs for this, check them out here - 
http://rubydoc.info/github/plataformatec/simple_form/master/SimpleForm/FormBuilder:input_field
----------------------------------------------------------------
Multiple Checkboxes with HABTM

Has and Belongs to Many with Multiple Check boxes

So if you are trying to do a multiple select of checkboxes and 
using habtm in your project, but when you submit the form, only 
one value was available in your controller. While you try to 
edit records in database but because of some error you get back 
to the pre field form and you found that the checkboxes checked 
by you gone ,then here’s the solution

Model:

  class Customer < ActiveRecord::Base
    has_and_belongs_to_many :intrests
  end

Controller code:

class CustomersController < ApplicationController
   def create
      if request.post?
         @customer=Customer.new(params[:customer])
         @customer.save
      end
   end

   def edit
      @customer=Customer.find_by_id(params[:id]) if params[:id]
      if @customer
         if request.post?
            if @customer.update_attributes(customer)
               flash.now[:message]="Update successfully "
            end 
         end
      else
        flash[:message]="Page requested by you does not exists"
      end
   end
end

Your View:

 <% form_for :customer,  do |f| -%>
    First Name:
      <%= f.text_field :first_name  -%>
    Last Name:
      <%= f.text_field :last_name -%>
      <% for  intr in total_intrests -%>
         <%= check_box_tag "customer[interest_ids][]", "#{intr.id}", interest(intr) -%> # interest is a helper method
         <%= "#{intr.name}" -%>
      <% end -%>
   <% end -%>

helper method

   def interest(i)
      if @customer
         @customer.interests.include?(i)
      else
        false
      end
   end

View generate a checkbox for every interest(all_interest=Interest.find(:all)). 
The name of the input is significant obviously. The trailing “[]” on the name 
means the end result will be the list of checked ids. This list will be stored 
on the @params[‘customer’] hash with the key ‘interest_ids’. When the controller 
calls @customer.update_attributes(@params[:customer]), it tries to call 
@customer.key= for each of the keys on @params[:customer]. What’s important 
to realize is that these keys don’t have to actually be attributes on the 
Customer model. All that’s important is that there’s a key= method on the model. 
Model automatically contains a “collection_ids=” method for habtm and has-many 
associations.

This method will load the objects identified by the ids and call the 
“interest=(list)” method on the model with the freshly loaded list. 
This method in turn, will compare the list to the current list of 
interests and delete/add interests as necessary.
--------------------------------------------------------------------
Prerequisites:

    Ruby 1.9.2+
    Rails 4.1.0+
    Traditional Database (MySQL/Postgres)

Key-Entities:

    Person Model
    Communtiy Model
    A Join Table

Defining the Relationships & creating tables:

1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43   

#{PATH_TO_APP}$ rails g model Person name:string email:string
#{PATH_TO_APP}$ rails g model Community name:string description:text
 
class Person < ActiveRecord::Base
has_and_belongs_to_many :communities
end
 
class Community < ActiveRecord::Base
has_and_belongs_to_many :persons
end
 
class CreatePeople < ActiveRecord::Migration
def change
create_table :people do |t|
t.string :name, null: false
t.string :email, null: false
t.timestamps
end
end
end
 
class CreateCommunities < ActiveRecord::Migration
def change
create_table :communities do |t|
t.string :name, null: false
t.text :description
t.timestamps
end
end
end
 
# {PATH_TO_APP}$ rails g migration CreateJoinTablePersonCommunity person community
# invoke active_record
# create db/migrate/20140708122358_create_join_table_person_community.rb
 
class CreateJoinTablePersonCommunity < ActiveRecord::Migration
  def change
    create_join_table :people, :communities, column_options: {null: true} do |t|
    # t.index [:person_id, :community_id]
    # t.index [:community_id, :person_id]
    end
  end
end

view raw my-habtm.rb hosted with ❤ by GitHub

For rest of the code-flow (controllers, views) you can download the zip of the application from my GitHub page, run it on your local and see Rails4 HABTM in action.

------------------------------------------------------------------------------
