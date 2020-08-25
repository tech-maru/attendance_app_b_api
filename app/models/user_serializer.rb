class UserSerializer
  include FastJsonapi::ObjectSerializer

  has_many :attendances, serializer: AttendanceSerializer
  attributes :id, :name
  
end
