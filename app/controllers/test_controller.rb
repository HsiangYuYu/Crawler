class TestController < ApplicationController
    require 'json'
    require 'open-uri'
    require 'uri'
    require 'erb'
    def index
        
    end
    
    def search
        @original_name = params[:search]
        @name =  ERB::Util.url_encode(params[:search]) #與javascript的encodeURIComponent()相同,可將中文轉成網址編碼
        @page = params[:page] #第幾頁
        @view = params[:view] #要使用哪種view
        case @view.to_i
          when 1 #精準度排列
            url = URI("http://ecshweb.pchome.com.tw/search/v3.3/all/results?q=#{@name}&sort=rnk/dc&page=#{@page}")   
            @color1 = "#DEDEDE"
          when 2 #升序排列
            url = URI("http://ecshweb.pchome.com.tw/search/v3.3/all/results?q=#{@name}&sort=prc/ac&page=#{@page}")  
            @color2 = "#DEDEDE"
          when 3 #降序排列
            url = URI("http://ecshweb.pchome.com.tw/search/v3.3/all/results?q=#{@name}&sort=prc/dc&page=#{@page}")  
            @color3 = "#DEDEDE"
          when 4 #新上市
            url = URI("http://ecshweb.pchome.com.tw/search/v3.3/all/results?q=#{@name}&sort=new/dc&page=#{@page}") 
            @color4 = "#DEDEDE"
        end
        @contents = JSON.parse(url.read)
        @data = @contents['prods']
        @totalPage = @contents['totalPage']
        

        respond_to do |format|
            format.js
        end
    end
    
    def create
      @i = params[:i]
      if(!Cart.exists?(name: params[:name])) #如果資料庫沒有那筆名子
          Cart.create(name: params[:name] , price: params[:price])
          @check_in_cart = false
      else
          @check_in_cart = true
      end
          respond_to do |format|
            format.js
          end
    end
end
