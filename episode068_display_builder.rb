 class PersonalAccount
  def display(r)
    r.name("#{first_name} #{last_name}")
    r.email(email)
  end
end

class CorporateAccount
  def display(r)
    r.name(company_name)
    r.email(email)
    r.tax_id(tax_id)
  end
end

class TrialAccount
  def display(r)
    r.name("Trial Account User")
    r.email(email)
  end
end
# renderers
class CsvRenderer
  def initialize(destination)
    @csv = CSV.new(destination)
  end

  def method_missing(name, value=nil)
    @csv << [name, value]
  end
end

class HtmlAccountRenderer
  def method_missing(name, value=nil)
    instance_variable_set("@#{name}", value)
  end

  def render
    <<"END"
<div class="account vcard">
  <p>
    Account details for:
    <span class="email">#{@email}</span>
  </p>
  <p class="fn">#{@name}</p>
</div>
END
  end
end

pa = PersonalAccount.new("Tom", "Servo", "tservo@example.org")

ca = CorporateAccount.new(
  "Yoyodyne",
  "john@example.org")

ta = TrialAccount.new("crooooow@example.org")
# using the renderer
puts "Personal Account:"
renderer = HtmlAccountRenderer.new
pa.display(renderer)
puts renderer.render

puts "\nCorporate Account:"
renderer = HtmlAccountRenderer.new
ca.display(renderer)
puts renderer.render

puts "\nTrial Account:"
renderer = HtmlAccountRenderer.new
ta.display(renderer)
puts renderer.render
