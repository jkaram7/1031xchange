class AcquisitionCriteriaController < ApplicationController
  def index
    matching_acquisition_criteria = AcquisitionCriterium.all

    @list_of_acquisition_criteria = matching_acquisition_criteria.order({ :created_at => :desc })

    render({ :template => "acquisition_criteria/index.html.erb" })
  end

  def show

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

    matching_acquisition_criteria = AcquisitionCriterium.where({ :id => the_id })

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
    the_acquisition_criterium.id_user = params.fetch("query_id_user")
    the_acquisition_criterium.notes = params.fetch("query_notes")
    the_acquisition_criterium.active = params.fetch("query_active", false)
    the_acquisition_criterium.priority = params.fetch("query_priority")
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

    the_acquisition_criterium.destroy

    redirect_to("/acquisition_criteria", { :notice => "Acquisition criterium deleted successfully."} )
  end
end
