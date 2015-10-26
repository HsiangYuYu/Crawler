class TestController < ApplicationController
    require 'json'
    require 'open-uri'
    require 'uri'
    require 'erb'
    def index
        
    end
    
    def search
        @original_name = params[:search]
        @name =  ERB::Util.url_encode(params[:search]) #與javascript的encodeURIComponent()相同
        @page = params[:page]
        @view = params[:view]
        case @view.to_i
        when 1
            url = URI("http://ecshweb.pchome.com.tw/search/v3.3/all/results?q=#{@name}&sort=rnk/dc&page=#{@page}")   #精準度排列
        when 2 
            url = URI("http://ecshweb.pchome.com.tw/search/v3.3/all/results?q=#{@name}&sort=prc/ac&page=#{@page}")  #升序排列
        when 3
            url = URI("http://ecshweb.pchome.com.tw/search/v3.3/all/results?q=#{@name}&sort=prc/dc&page=#{@page}")  #降序排列
        when 4
            url = URI("http://ecshweb.pchome.com.tw/search/v3.3/all/results?q=#{@name}&sort=new/dc&page=#{@page}") #新上市
        end
        @contents = JSON.parse(url.read)
        @data = @contents['prods']
        @totalPage = @contents['totalPage']
        
        respond_to do |format|
            format.js
        end
    end
end
