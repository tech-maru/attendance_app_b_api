class AttendancesSerializer
  include FastJsonapi::ObjectSerializer

  attributes :attendances[]
  
end