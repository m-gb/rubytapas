auth = {
  'uid'  => 12345,
  'info' => {
    'email'      => 'avdi@avdi.org'
    'first_name' => 'avdi',
    'last_name'  => 'grimm'
  },
  'credentials' => {
    'token' => "TOKEN123"
  }
}

User = Struct.new(:email_address, :first_name, :last_name, :token)

u = User.new

u.email_address = auth['info'].fetch('email'])
u.first_name    = auth['info'].fetch('first_name')
u.last_name     = auth['info'].fetch('last_name')
u.token         = auth.fetch('credentials').fetch('token')
