= PostCodeAnywhere BankAccountValidation

A very simple wrapper for the PostCodeAnywhere [Bank Account Validation API](http://www.postcodeanywhere.co.uk/support/webservices/BankAccountValidation/Interactive/Validate/v2/default.aspx).

== Usage

    PostcodeAnywhereBank::AccountValidation.authenticate "AA11-AA11-AA11-AA11"
    result = PostcodeAnywhereBank::AccountValidation.validate :account_number => "12345678", :sort_code => "11-22-33"
    
    if result.error
      result.error_message            => "AccountNumber Required: The AccountNumber parameter was not supplied. Please ensure that you supply the AccountNumber parameter and try again."
    else
      result.is_correct               => true
      result.is_direct_debit_capable  => true
      result.status_information       => "OK"
    end

== Contributing to postcodeanywhere-banking
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

== Copyright

Copyright (c) 2011 Aaron Russell. See LICENSE.txt for
further details.

