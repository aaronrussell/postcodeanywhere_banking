require "httparty"
require File.join(File.dirname(__FILE__), "httparty_icebox")

module PostcodeAnywhere
  
  class BankAccountValidation
    
    HEADERS = {
      "User-Agent"    => "Ruby.PostcodeAnywhere.BankAccountValidation",
      "Accept"        => "application/json",
      "Content-Type"  => "application/json"
    }
    
    include HTTParty
    include HTTParty::Icebox
    
    base_uri "https://services.postcodeanywhere.co.uk/BankAccountValidation/Interactive/Validate/v2.00/"
    headers HEADERS
    format :json
    cache :timeout => 43200
    
    def self.authenticate(api_key)
      default_params "Key" => api_key
    end
    
    def self.validate(opts)
      res = get "/json.ws", :query => {"AccountNumber" => opts[:account_number], "SortCode" => opts[:sort_code]}
      res.code == 200 ? BankAccountValidationResponse.new(res.parsed_response[0]) : res
    end
    
  end
  
  class BankAccountValidationResponse
    
    attr_reader :is_correct, :is_direct_debit_capable, :status_nformation, :corrected_sort_code, :corrected_account_number,
                :iban, :bank, :bank_bic, :branch, :branch_bic, :faster_payments_supported, :chaps_supported,
                :contact_address_line1, :contact_address_line2, :contact_post_town, :contact_postcode, :contact_phone, :contact_fax
    attr_reader :error, :error_code, :error_message, :description, :cause, :resolution
    
    def initialize(res = {})
      res.keys.each do |att|
        instance_variable_set "@#{underscore(att)}".to_sym, res[att]
      end
      @error = res["Error"] ? true : false
      if @error
        @error_code = res["Error"]
        @error_message = "#{@description}: #{@cause} #{@resolution}"
      else
        ["@is_correct", "@is_direct_debit_capable", "@faster_payments_supported", "@chaps_supported"].each do |att|
          instance_variable_set att.to_sym, (instance_variable_get(att) == "True" ? true : false)
        end
      end
    end
    
    private
    
    def underscore(camel_cased_word)
      word = camel_cased_word.to_s.dup
      word.gsub!(/::/, '/')
      word.gsub!(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
      word.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
      word.tr!("-", "_")
      word.downcase!
      word
    end
    
  end
  
end
