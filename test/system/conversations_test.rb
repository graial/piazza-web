require "application_system_test_case"
class ConversationsTest < ApplicationSystemTestCase
	setup do
		@user = users(:jerry)
		@conversation_one = conversations(:kramer_jerry_1)
		@conversation_two = conversations(:jerry_elaine_1)
	
		log_in(@user)
	end
	
	test "active conversation has border" do
		visit conversations_path
		
		find("##{dom_id(@conversation_one)}").click
		assert_selector "##{dom_id(@conversation_one, :messages)}"
		assert_selector "##{dom_id(@conversation_one)}.is-active"
		
		find("##{dom_id(@conversation_two)}").click
		assert_selector "##{dom_id(@conversation_two, :messages)}"
		assert_selector "##{dom_id(@conversation_two)}.is-active"
		assert_selector ".is-active", count: 1
	end

	test "new message has dark background for sender" do
		visit conversations_path
		
		find("##{dom_id(@conversation_one)}").click
		@conversation_one.messages.create(
			body: "Yada, yada, yada",
			from: organizations(:jerry),
			sender: @user
		)
		assert_selector ".has-background-primary-dark > p", text: "Yada, yada, yada"
	end

	test "new message has light background for recipient" do
		visit conversations_path
		find("##{dom_id(@conversation_one)}").click
		@conversation_one.messages.create(
			body: "Yada, yada, yada",
			from: organizations(:kramer),
			sender: users(:kramer)
		)
		assert_selector ".box:not(.has-background-primary-dark) > p", text: "Yada, yada, yada"
	end
end