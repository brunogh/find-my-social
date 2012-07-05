require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Iteration" do
  it "resultadosdigitais.com.br" do
    body = Downloader.new.get("http://resultadosdigitais.com.br/blog/")
    twitter = Parser.new.get_twitter(body)
    twitter.should eq("ResDigitais")
  end
  
  it "soap.com.br" do
    body = Downloader.new.get("http://soap.com.br")
    twitter = Parser.new.get_twitter(body)
    twitter.should eq("soapbrasil")
  end
  
  it "beefpoint.com.br" do
    body = Downloader.new.get("http://beefpoint.com.br")
    twitter = Parser.new.get_twitter(body)
    twitter.should eq("")
  end
  
  it "hubspot.com" do
    body = Downloader.new.get("http://hubspot.com")
    twitter = Parser.new.get_twitter(body)
    twitter.should eq("hubspot")
  end  
  
  it "www.granatum.com.br" do
    body = Downloader.new.get("http://www.granatum.com.br")
    twitter = Parser.new.get_twitter(body)
    twitter.should eq("granatum_")
  end    
end