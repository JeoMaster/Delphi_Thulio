unit mongo.Anniversary.Reg;

interface

uses System.Classes;

procedure Register;

implementation

uses mongo.Anniversary.CalendarPicker, mongo.Anniversary.ToggleSwitch,
  mongo.Anniversary.CalendarView;

procedure Register;
begin
  RegisterComponents('MongoX10 Components', [TMongoCalendarView, TMongoCalendarPicker, TMongoToggleSwitch]);
end;

end.
