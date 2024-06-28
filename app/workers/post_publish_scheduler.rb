require 'sidekiq-scheduler'

class PostPublishScheduler
    include Sidekiq::Worker

    def perform 
        posts = Post.where('publish_at < ?', Time.now)
                    .where(published: false)
                    .where(schedule: true)

        post.each do |post|
            post.publish
        end
    end
end
