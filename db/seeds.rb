def log_seed_output(msg)
  puts "[ Seeding ] #{msg}\n"
end

if Rails.env.production?
  log_seed_output "Seed cannot run in production"
  log_seed_output "Exiting"
  return
end

ActiveRecord::Base.transaction do
  a = Time.now
  log_seed_output "-----------------------"
  log_seed_output "🌱 Seed Process started"
  log_seed_output "-----------------------"

  puts "\n\n"

  Dir[Rails.root.join("db", "seeds", "*.rb")].sort.each do |seed|
    # Print out file name
    puts "[ Seeding ] #{seed} started"
    load seed
    puts "[ Seeding ] #{seed} completed"
  end

  # Add seeds to create 50 pets in total
  50.times do |i|
    Pet.create!(
      name: "Pet #{i + 1}",
      birth_date: Date.today - (2 * i).days,
      sex: ['Male', 'Female'].sample,
      species: ['Dog', 'Cat'].sample,
      breed: ['Breed 1', 'Breed 2', 'Breed 3'].sample,
      description: "Description for Pet #{i + 1}",
      weight_from: rand(1..10),
      weight_to: rand(11..20),
      weight_unit: 'kg',
      placement_type: ['Adoptable', 'Fosterable', 'Adoptable and Fosterable'].sample,
      organization_id: Organization.first.id,
      published: [true, false].sample
    )
  end

  puts "\n\n"
  log_seed_output "-----------------------"
  log_seed_output "🌱 Seed Process ended in #{Time.now - a} seconds"
  log_seed_output "-----------------------"
end
