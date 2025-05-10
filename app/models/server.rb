class Server < ApplicationRecord
  enum :region, { americas: 0, europe: 1, africa: 2, ocean: 3 }
end
