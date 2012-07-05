class Parser
  
  def get_twitter(content)
    screen_name = content.scan(/<a href=\"(http|https):\/\/twitter.com\/([^<>]*)\" class=\"twitter-follow-button\"/i).flatten[1]
  
    if(screen_name.nil?)
      screen_name = content.scan(/href=\"(http|https):\/\/twitter.com\/(#!\/)?([^<>"]*)\"/i).flatten[2]
      
      if(screen_name.nil?)
        p content.scan(/href=\"(http|https):\/\/twitter.com\/intent\/([^<>"]*)screen_name=([^<>"]*)\"/i)
        screen_name = content.scan(/href=\"(http|https):\/\/twitter.com\/intent\/([^<>"]*)screen_name=([^<>"]*)\"/i).flatten[2]
      end
    end
    
    screen_name == "share" ? "" : screen_name
  end
  
end