namespace :photo_challenges do
  desc 'Compiles the SASS for the frontend'
  task compile_sass: :environment do
    `sass public/assets/sass/app.scss public/assets/css/app.css`
  end
end
