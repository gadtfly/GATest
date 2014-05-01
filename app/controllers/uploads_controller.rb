class UploadsController < ApplicationController
  def new
  end

  def create
    client = Google::APIClient.new
    client.authorization.access_token = Account.first.access_token
    analytics = client.discovered_api('analytics', 'v3')

    file = StringIO.new(GoogleAnalytics::CSVConverter.new(params[:csv]).to_s)
    date = Time.now.strftime('%Y-%m-%d')
    media = Google::APIClient::UploadIO.new(file, 'application/octet-stream')
    metadata = {
      'title'     => date,
      'mimeType'  => 'application/octet-stream',
      'resumable' => false
    }
    raise client.execute(
      api_method: analytics.management.daily_uploads.upload,
      parameters: { 'uploadType'          => 'multipart',
                    'appendNumber'        => 1,
                    'date'                => date,
                    'type'                => 'cost',
                    'accountId'           => '48677404',
                    'webPropertyId'       => 'UA-48677404-1',
                    'customDataSourceId'  => 'VgzS6Ob4RRWQIaxdHaVSug'
                  },
      media: media,
      body_object: metadata).inspect
  end
end
