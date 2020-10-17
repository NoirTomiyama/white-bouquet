class TopController < ApplicationController
  def index
    @message = "index"

    resource = Aws::S3::Resource.new(
      region: "ap-northeast-1",
      credentials: Aws::Credentials.new(
        ENV['AWS_ACCESS_KEY_ID'],
        ENV['AWS_SECRET_ACCESS_KEY']
      )
    )
    bucket = resource.bucket('my-bucket-sample-1038')

    @images = []
    bucket.objects.each do |object|
      if((object.key).include?('images/')) then
        puts "Name:  #{object.key}"
        puts "URL:   #{object.presigned_url(:get)}"
        # @image_url = object.presigned_url(:get)
        @images.push(object.presigned_url(:get))
      end
    end
  end

  def show
    @message = "show"

    resource = Aws::S3::Resource.new(
      region: "ap-northeast-1",
      credentials: Aws::Credentials.new(
        ENV['AWS_ACCESS_KEY_ID'],
        ENV['AWS_SECRET_ACCESS_KEY']
      )
    )
    bucket_name = 'my-bucket-sample-1038'
    bucket = resource.bucket('my-bucket-sample-1038')

    client = Aws::S3::Client.new(
      region: "ap-northeast-1",
      credentials: Aws::Credentials.new(
        ENV['AWS_ACCESS_KEY_ID'],
        ENV['AWS_SECRET_ACCESS_KEY']
      )
    )

    @object_list = []
    bucket.objects.each do |object|
      if((object.key).include?('result/')) then
        data = JSON.parse(client.get_object(bucket: bucket_name, key: object.key).body.read)
        image = bucket.object(data['image'])
        image_url = image.presigned_url(:get)
        name = data['name']
        score = data['score']
        item = {
          image: image_url,
          name: name,
          score: score
        }
        @object_list.push(item)
      end
    end
  end
end
