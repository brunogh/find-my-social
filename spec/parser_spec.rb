require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "get_twitter" do
  
  context "from original referer follow button" do
    it "find it correctly" do
      twitter = Parser.new.get_twitter(%(http://twitter.com/intent/follow?original_referer=http%3A%2F%2Fwww.google.com.br%2F&region=follow_link&screen_name=brunogh&source=followbutton&variant=2.0))
      twitter.should eq("brunogh")
    end
  end
  
  context "from twitter follow button" do
    
    context "without username" do
      
      context "and http" do
        it "find it correctly" do
          twitter = Parser.new.get_twitter(%(<a href="http://twitter.com/brunogh" class="twitter-follow-button" data-show-count="false" data-show-screen-name="false">Follow @brunogh</a><script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>))
          twitter.should eq("brunogh")
        end
      end
      
      context "and https" do
        it "find it correctly" do
          twitter = Parser.new.get_twitter(%(<a href="https://twitter.com/brunogh" class="twitter-follow-button" data-show-count="false" data-show-screen-name="false">Follow @brunogh</a><script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>))
          twitter.should eq("brunogh")
        end
      end      
    end
    
    context "with username" do
      context "and http" do
        it "find it correctly" do
          twitter = Parser.new.get_twitter(%(<a href="http://twitter.com/brunogh" class="twitter-follow-button" data-show-count="false">Follow @brunogh</a><script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>))
          twitter.should eq("brunogh")
        end
      end
      
      context "and https" do
        it "find it correctly" do
          twitter = Parser.new.get_twitter(%(<a href="https://twitter.com/brunogh" class="twitter-follow-button" data-show-count="false">Follow @brunogh</a><script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>))
          twitter.should eq("brunogh")
        end
      end      
    end    
    
    context "from link" do
      
      it "with class" do
        twitter = Parser.new.get_twitter(%(<a href="https://twitter.com/brunogh" class=\"\">brunogh</a>))
        twitter.should eq("brunogh")
      end    
      
      context "with hashbang" do
        
        context "with http" do
           it "find it correctly" do
            twitter = Parser.new.get_twitter(%(<a href="http://twitter.com/#!/brunogh">brunogh</a>))
            twitter.should eq("brunogh")
          end       
        end
        
        context "with https" do
          it "find it correctly" do
            twitter = Parser.new.get_twitter(%(<a href="https://twitter.com/#!/brunogh">brunogh</a>))
            twitter.should eq("brunogh")
          end        
        end
        
      end
      
      context "without hashbang" do
        context "with http" do
           it "find it correctly" do
            twitter = Parser.new.get_twitter(%(<a href="http://twitter.com/brunogh">brunogh</a>))
            twitter.should eq("brunogh")
          end       
        end
        
        context "with https" do
          it "find it correctly" do
            twitter = Parser.new.get_twitter(%(<a href="https://twitter.com/brunogh">brunogh</a>))
            twitter.should eq("brunogh")
          end        
        end        
      end
      
      context "share twitter" do
        it "returns empty" do
          twitter = Parser.new.get_twitter(%(<a href="http://twitter.com/share" class="twitter-share-button" data-url="http://www.beefpoint.com.br/cadeia-produtiva/giro-do-boi/cade-aprova-troca-de-ativos-entre-brf-e-marfrig/" data-count="horizontal" data-text="CADE aprova troca de ativos entre BRF e Marfrig" data-via="beefpoint" ></a>))
          twitter.should eq("")
        end
      end
      
      
    end
    
  end
end