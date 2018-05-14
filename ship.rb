def shipment_total
	# get the route mapping for the shipment truck. This helps in determining the cost with the criteria
	tr = TruckRoute.find_by(truck_id: shipment.truck.id, route_id: shipment.route.id)

	# get the shipping company to get their kg config
	shipping_company = shipment.truck.courier_company
	
	# initialize  total kg to 0
	total_extra_kg = 0

	# get extra kg after the initial kg has been taken out
	total_extra_kg = ((self.weight - shipping_company.initial_kg) / shipping_company.extra_kg_step).ceil

	# get all the possible criteria for the truck and route for the shipment stored against it
	charg_by = tr.charge_criteria.pluck(:charge_by_type)

	# initialize cost to 0
	total = 0

	# for instance we can check if the array contains kilometer since a distance can cover so many kilometer
	if charg_by.include?("kilometer")
		total  = (tr.cost_per_initial_kg * self.route.distance) + (total_extra_kg * tr.cost_per_extra_kg * self.route.distance)
	else

		# if there is no kilometer in the criteria it could mean that every order criteria does not require
		# extra calculation as that is already accounted for in the extra kg cost specified
		total  = (tr.cost_per_initial_kg * self.route.distance) + (total_extra_kg * tr.cost_per_extra_kg)
	end
	total
end