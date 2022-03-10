class AcquisitionCriteriaController < ApplicationController
  def filter

    render({ :template => "acquisition_criteria/filter.html.erb" })
  end
  
  def index
    matching_acquisition_criteria = AcquisitionCriterium.all

    @list_of_acquisition_criteria = matching_acquisition_criteria.where({:active => true}).order({ :created_at => :desc })

    render({ :template => "acquisition_criteria/index.html.erb" })
  end

  def index_sort_filter
    matching_acquisition_criteria = AcquisitionCriterium.all
    
    filter_dates = params.fetch("filter_dates")
    filter_datel = params.fetch("filter_datel")
    filter_type = params.fetch("filter_type")
    filter_location = params.fetch("filter_location")
    filter_sizes = params.fetch("filter_sizes")
    filter_sizel = params.fetch("filter_sizel")
    filter_mins = params.fetch("filter_mins")
    filter_minl = params.fetch("filter_minl")
    filter_maxs = params.fetch("filter_maxs")
    filter_maxl = params.fetch("filter_maxl")
    filter_subtype = params.fetch("filter_subtype")
    filter_occupancy = params.fetch("filter_occupancy")
    filter_profile = params.fetch("filter_profile")
    filter_tenant = params.fetch("filter_tenant")
    filter_sqfts = params.fetch("filter_sqfts")
    filter_sqftl = params.fetch("filter_sqftl")

    sort_by = params.fetch("sort_by", false)
    asc = params.fetch("asc", false)

    sort_criteria = 0

    if sort_by == "Type"
      sort_criteria = 1
    elsif sort_by == "Loc."
      sort_criteria = 3
    elsif sort_by == "Size"
      sort_criteria = 5
    elsif sort_by == "Posted"
      sort_criteria = 7
    end

    if sort_criteria != 0
      if asc == true
        sort_criteria = sort_criteria + 1
      end
    end


    @list_of_acquisition_criteria = matching_acquisition_criteria.where({:active => true}).order({ :created_at => :desc })

    if filter_dates != ""
      @list_of_acquisition_criteria =@list_of_acquisition_criteria.where("period_end_date > ?", filter_dates)
    end

    if filter_datel != ""
      @list_of_acquisition_criteria =@list_of_acquisition_criteria.where("period_end_date < ?", filter_datel)
    end

    if filter_type != ""
      @list_of_acquisition_criteria =@list_of_acquisition_criteria.where({:product_type => filter_type})
    end

    if filter_location != ""
      @list_of_acquisition_criteria =@list_of_acquisition_criteria.where({:location => filter_location})
    end

    if filter_sizes != ""
      @list_of_acquisition_criteria =@list_of_acquisition_criteria.where("trade_size > ?", filter_sizes)
    end

    if filter_sizel != ""
      @list_of_acquisition_criteria =@list_of_acquisition_criteria.where("trade_size < ?", filter_sizel)
    end

    if filter_mins != ""
      @list_of_acquisition_criteria =@list_of_acquisition_criteria.where("cap_rate_min > ?", filter_mins)
    end

    if filter_minl != ""
      @list_of_acquisition_criteria =@list_of_acquisition_criteria.where("cap_rate_min < ?", filter_minl)
    end

    if filter_maxs != ""
      @list_of_acquisition_criteria =@list_of_acquisition_criteria.where("cap_rate_max > ?", filter_maxs)
    end

    if filter_maxl != ""
      @list_of_acquisition_criteria =@list_of_acquisition_criteria.where("cap_rate_max < ?", filter_maxl)
    end

    if filter_subtype != ""
      @list_of_acquisition_criteria =@list_of_acquisition_criteria.where({:property_sub_type => filter_subtype})
    end

    if filter_occupancy != ""
      @list_of_acquisition_criteria =@list_of_acquisition_criteria.where({:occupancy => filter_occupancy})
    end

    if filter_profile != ""
      @list_of_acquisition_criteria =@list_of_acquisition_criteria.where({:return_profile => filter_profile})
    end

    if filter_tenant != ""
      @list_of_acquisition_criteria =@list_of_acquisition_criteria.where({:preferred_tenant => filter_tenant})
    end

    if filter_sqfts != ""
      @list_of_acquisition_criteria =@list_of_acquisition_criteria.where("sq_feet > ?", filter_sqfts)
    end

    if filter_sqftl != ""
      @list_of_acquisition_criteria =@list_of_acquisition_criteria.where("sq_feet < ?", filter_sqftl)
    end

    if sort_criteria != ""
    if sort_criteria == 1
      @list_of_acquisition_criteria =@list_of_acquisition_criteria.order({ :product_type => :desc })
    elsif sort_criteria == 2
      @list_of_acquisition_criteria =@list_of_acquisition_criteria.order({ :product_type => :asc })
    elsif sort_criteria == 3
      @list_of_acquisition_criteria =@list_of_acquisition_criteria.order({ :location => :asc })
    elsif sort_criteria == 4
      @list_of_acquisition_criteria =@list_of_acquisition_criteria.order({ :location => :asc })
    elsif sort_criteria == 5
      @list_of_acquisition_criteria =@list_of_acquisition_criteria.order({ :trade_size => :desc })
    elsif sort_criteria == 6
      @list_of_acquisition_criteria =@list_of_acquisition_criteria.order({ :trade_size => :asc })
    elsif sort_criteria == 7
      @list_of_acquisition_criteria =@list_of_acquisition_criteria.order({ :created_at => :asc })
    elsif sort_criteria == 8
      @list_of_acquisition_criteria =@list_of_acquisition_criteria.order({ :created_at => :asc })
    end
    end

    render({ :template => "acquisition_criteria/index.html.erb" })
  end

  def show

    #already a connection?
    id_acquisition = params.fetch("path_id")

    matching_messages = Message.where(sender_id: session.fetch(:user_id)).where({:acquisition_id => id_acquisition})

    @list_of_messages = matching_messages


    #log a user clicking the link
    the_view = View.new
    the_view.id_acquisition = params.fetch("path_id")
    the_view.id_viewer = session.fetch(:user_id)
    the_view.clicked = true
    the_view.potential_lead = false

    if the_view.valid?
      the_view.save
    end

    #now show criteria
    the_id = params.fetch("path_id")

    matching_acquisition_criteria = AcquisitionCriterium.where({ :id => the_id }).where({:active => true})

    @the_acquisition_criterium = matching_acquisition_criteria.at(0)

    render({ :template => "acquisition_criteria/show.html.erb" })
  end

  def create
    the_acquisition_criterium = AcquisitionCriterium.new
    the_acquisition_criterium.period_end_date = params.fetch("query_period_end_date")
    the_acquisition_criterium.product_type = params.fetch("query_product_type")
    the_acquisition_criterium.location = params.fetch("query_location")
    the_acquisition_criterium.trade_size = params.fetch("query_trade_size")
    the_acquisition_criterium.id_user = session.fetch(:user_id)
    the_acquisition_criterium.notes = params.fetch("query_notes")
    the_acquisition_criterium.active = true
    the_acquisition_criterium.priority = 1
    the_acquisition_criterium.cap_rate_min = params.fetch("query_cap_rate_min")
    the_acquisition_criterium.cap_rate_max = params.fetch("query_cap_rate_max")
    the_acquisition_criterium.property_sub_type = params.fetch("query_property_sub_type")
    the_acquisition_criterium.occupancy = params.fetch("query_occupancy")
    the_acquisition_criterium.return_profile = params.fetch("query_return_profile")
    the_acquisition_criterium.preferred_tenant = params.fetch("query_preferred_tenant")
    the_acquisition_criterium.sq_feet = params.fetch("query_sq_feet")

    if the_acquisition_criterium.valid?
      the_acquisition_criterium.save
      redirect_to("/", { :notice => "Acquisition criterium created successfully." })
    else
      redirect_to("/", { :notice => "Acquisition criterium failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_acquisition_criterium = AcquisitionCriterium.where({ :id => the_id }).at(0)

    the_acquisition_criterium.period_end_date = params.fetch("query_period_end_date")
    the_acquisition_criterium.product_type = params.fetch("query_product_type")
    the_acquisition_criterium.location = params.fetch("query_location")
    the_acquisition_criterium.trade_size = params.fetch("query_trade_size")
    the_acquisition_criterium.id_user = session.fetch(:user_id)
    the_acquisition_criterium.notes = params.fetch("query_notes")
    the_acquisition_criterium.active = true
    the_acquisition_criterium.cap_rate_min = params.fetch("query_cap_rate_min")
    the_acquisition_criterium.cap_rate_max = params.fetch("query_cap_rate_max")
    the_acquisition_criterium.property_sub_type = params.fetch("query_property_sub_type")
    the_acquisition_criterium.occupancy = params.fetch("query_occupancy")
    the_acquisition_criterium.return_profile = params.fetch("query_return_profile")
    the_acquisition_criterium.preferred_tenant = params.fetch("query_preferred_tenant")
    the_acquisition_criterium.sq_feet = params.fetch("query_sq_feet")

    if the_acquisition_criterium.valid?
      the_acquisition_criterium.save
      redirect_to("/acquisition_criteria/#{the_acquisition_criterium.id}", { :notice => "Acquisition criterium updated successfully."} )
    else
      redirect_to("/acquisition_criteria/#{the_acquisition_criterium.id}", { :alert => "Acquisition criterium failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_acquisition_criterium = AcquisitionCriterium.where({ :id => the_id }).at(0)

    the_acquisition_criterium.active = false
    the_acquisition_criterium.save

    redirect_to("/acquisition_criteria", { :notice => "Acquisition criterium deleted successfully."} )
  end
end
