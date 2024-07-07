## Queuing Theory Application for Traffic Analysis

Queuing theory offers a mathematical framework to analyze and predict the behavior of queues, such as waiting lines. This theory can be effectively applied to model and optimize traffic flow at ramp lights. Here’s how:

### Key Parameters Utilized in Queuing Theory:

- **Arrival Rate (λ):** The rate at which vehicles arrive at the ramp lights.
- **Service Rate (μ):** The rate at which vehicles are served and proceed through the ramp lights.
- **Queue Length:** The number of vehicles waiting at the ramp lights at any given time.
- **Service Time:** The time it takes for a vehicle to proceed through the ramp lights once it begins moving.
- **Utilization Factor (ρ):** The ratio of the arrival rate to the service rate (ρ = λ/μ).

### Data Collection Methodology:

To model the queuing system at the ramp lights, data was collected by periodically refreshing a website to obtain snapshots at consistent intervals. Despite random updates, vehicles could be observed in consecutive images with varying time gaps. This allowed calculation of arrival and service rates based on vehicle positions and time intervals between snapshots. Queue length during each interval was also determined by counting vehicles.

### Approach:

- **Separate Lane Analysis:** Parameters were calculated separately for each lane due to independent serving points. Vehicles enter specific lanes from different locations without queue choice, aiding precise analysis of vehicle flow and congestion management during peak hours.
