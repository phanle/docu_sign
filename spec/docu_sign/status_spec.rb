require File.dirname(__FILE__) + '/../spec_helper'

describe "Status and Managing functions" do
  before do
    @client = build_client
  end

  describe "request_envelope" do
    use_vcr_cassette :request_envelope
    before do
      @envelope_id = create_docusign_envelope
    end

    it "should correctly retrieve an envelope given an envelope id" do
      @envelope = @client.request_envelope({"EnvelopeID" => @envelope_id, "IncludeDocumentBytes" => "false"})
      @envelope.should be_an_instance_of(DocuSign::Envelope)
    end
  end
  
  describe "request_status" do
    use_vcr_cassette :request_status
    before do
      @envelope_id = create_docusign_envelope
    end
    
    it "should correctly retrieve an envelope status given an envelope id" do
      @envelope_status = @client.request_status(:envelope_id => @envelope_id)
      @envelope_status.recipient_statuses.first.status.should eq("Sent")
    end
  end

  describe "void_envelope" do
    use_vcr_cassette :void_envelope
    before do
      @envelope_id = create_docusign_envelope
    end

    it "should correctly void an envelope given an envelope id" do
      @void = @client.void_envelope({"EnvelopeID" => @envelope_id, "Reason" => "Booking Cancelled"})
      @void.should be_an_instance_of(DocuSign::VoidEnvelopeStatus)
      @void.void_success.should be_true
    end

    it "should work with snake case input parameters" do
      @void = @client.void_envelope(:envelope_id => @envelope_id, :reason => "Booking Cancelled")
      @void.should be_an_instance_of(DocuSign::VoidEnvelopeStatus)
      @void.void_success.should be_true
    end
  end
end