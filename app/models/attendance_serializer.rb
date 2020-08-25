class AttendanceSerializer
  include FastJsonapi::ObjectSerializer

  belongs_to :user, serializer: UserSerializer
  attributes :worked_on
  attributes :started_at
  attributes :finished_at
  
end