class SandboxController < ApplicationController
  def product
  	@prod_categories = Product.where('category=?','Movies')
  	@pricerange = Product.where('price >? AND price < ?','1','10')
  	@brand = Product.where('brand=?','Puma')
  	@size = Product.where('size=? AND brand =? AND price>? AND price <?','M','Nike','1','50')
  	@available = Product.where('availability=?','t')
  	@pricer = Product.where('price <?','499')
  	@pricem = Product.where('price <= ?','1200')
  	@prp = Product.order('price DESC,name')
  	@prod = Product.sum(:price)
  	#@prod_sum=Product.calculate_total_price
  	#@categories = Product.pluck(:category).uniq
  end

  def clients
   @clients = Client.order('name')
  end

  def projects 
     @allprojects = Project.all
     @projects = Project.where('start_date>?',Date.today.beginning_of_month)
  end

  def get_jobs
    if params[:technology]
      technology = params[:technology]
      location = params[:location]
            @response = HTTParty.get("http://api.indeed.com/ads/apisearch?publisher=7277146494571922&q=#{technology}&l=#{location}&co=india&format=json&v=2")
    end
  end
end
