class TopController < ApplicationController
  def index
    @message = "index"
    s3 = Aws::S3::Resource.new(
      region: "ap-northeast-1",
      credentials: Aws::Credentials.new(
        ENV['AWS_ACCESS_KEY_ID'],
        ENV['AWS_SECRET_ACCESS_KEY']
      )
    )
    bucket = s3.bucket('my-bucket-sample-1038')

    @images = []
    bucket.objects.each do |item|
      puts "Name:  #{item.key}"
      puts "URL:   #{item.presigned_url(:get)}"
      # @image_url = item.presigned_url(:get)
      @images.push(item.presigned_url(:get))
    end
    # obj = bucket.object('test/test.png')
    # @image_url = obj.presigned_url(:get)
  end
    
  def show
    @message = "show"
  end
end
