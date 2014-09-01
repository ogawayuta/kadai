require 'haml'
require 'sinatra'

set :bind, '0.0.0.0'
set :public_folder, File.dirname(__FILE__) + '/static'

get '/zisa' do
  #@time = Time.now.strftime("%Y-%m-%d %H:%M:%S")
  @time = Time.now
  haml :zisa
end

post '/zisa' do
  place = params['place']
  STDERR.puts place
  class Time 
    def timezone(timezone = 'UTC')
      old = ENV['TZ']
      utc = self.dup.utc
      ENV['TZ'] = timezone
      output = utc.localtime
      ENV['TZ'] = old
      output
    end
  end
  @time = Time.now
  @time2 = Time.now
  if place == "ニューヨーク"
    @zisa = "#{place}\n#{@time2.timezone('America/New_York')}"
  elsif place == "香港"
    @zisa = "#{place}:#{@time2.timezone('Asia/Hong_Kong')}"
  elsif place == "ロンドン"
    @zisa = "#{place}:#{@time2.timezone('Europe/London')}"
  elsif place == "カイロ"
    @zisa = "#{place}:#{@time2.timezone('Africa/Cairo')}"
  else
    @zisa = "#{place}:#{@time2.timezone('Asia/Singapore')}"
  end
  haml :zisa_kekka
end

