Rails.application.routes.draw do
  get 'employee_card/overview'
  get 'employee_card/musco'
  get 'employee_card/fatigue'
  get 'employee_card/hydration'
  get 'employee_card/mental'
  get 'employee_card/aod'
  get 'employee_card/devices'

  post 'employee_card/mental', to: 'employee_card#save_wellness'

  root to: 'employee_card#overview'
end
