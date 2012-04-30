require File.dirname(__FILE__) + '/../spec_helper'

describe "request recipient token" do
  before do
    @client = build_client
  end

  #describe "request recipient token" do
    #use_vcr_cassette :request_envelope
  #end

  describe 'getting recipient token' do
    use_vcr_cassette :request_recipient_token
    before do
      @envelope_id = create_docusign_envelope
    end

    it "should correctly retrieve an embedded signing url" do
      request_recipient_token = @client.request_recipient_token(
        {"envelope_id" => @envelope_id,
         "username" => "Recipient 1",
         "email" => "donald@donaldpiret.com",
          "client_user_id" => 1,
          'authentication_assertion' => {
            'assertion_id' => Time.now.to_i.to_s,
            'authentication_instant' => DateTime.now,
            'authentication_method' => 'Password',
            'security_domain' => 'https://demo.example.com',
          },
         "ClientURLs" => {
           'OnSigningComplete' => 'https://demo.example.com',
           'OnDecline' => 'https://demo.example.com',
           'OnViewingComplete' => 'https://demo.example.com',
           'OnException' => 'https://demo.example.com',
           'OnCancel' => 'https://demo.example.com',
           'OnTTLExpired' => 'https://demo.example.com',
           'OnSessionTimeout'=> 'https://demo.example.com'
         }
      })
      request_recipient_token.should be_an_instance_of(DocuSign::RecipientToken)
      request_recipient_token.url.should =~ %r{^https://.*docusign.*}
    end
  end
end

