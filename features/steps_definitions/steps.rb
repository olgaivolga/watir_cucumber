require 'rubygems'
require 'watir-webdriver'
require 'test/unit'
include Test::Unit::Assertions
 
Given /^a front page$/ do
    @browser.goto "http://echoplatform.com/sandbox/staging/appserver"
end

When /^a user logs in as "([^"]*)" with password "([^"]*)"$/ do |username, password|
    @browser.div(:class => "btn echo-appserver-auth-login-label").when_present.click
    @browser.div(:class => "modal fade in").wait_until_present
    janrainSwitchAccountLink = @browser.link(:class => "janrainSwitchAccountLink").exists?
    #print janrainSwitchAccountLink 
    if janrainSwitchAccountLink
        @browser.link(:class => "janrainSwitchAccountLink").click
    end
    @browser.span(:class => "janrain-provider-text-color-twitter").when_present.click
    @browser.window(:index => 1).use do
        @browser.text_field(:id, "username_or_email").set username
        @browser.text_field(:id, "password").set password
        @browser.button(:id => "allow").click
    end
end

When /^a user logs out$/ do
    @browser.span(:class => 'echo-appserver-auth-name').click
    @browser.link(:text => 'Sign Out').click
end

Then /^a message for non admins is displayed$/ do 
    @browser.div(:class => 'echo-appserver-myapps-emptyCategory').wait_until_present
    assert_match(/You are logged into Echo Applications Dashboard/, @browser.div(:class => 'echo-appserver-myapps-emptyCategory').text)
end

Then /^a message for admins is displayed$/ do
        @browser.div(:class => 'echo-appserver-forms-customer-search-formDescription').wait_until_present
        assert_match(/Please insert customer ID, application key or customer domain and we\'ll try to find the customer for you!/, @browser.div(:class => 'echo-appserver-forms-customer-search-formDescription').text)
end

