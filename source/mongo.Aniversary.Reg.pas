unit mongo.Aniversary.Reg;

interface

uses System.Classes;

procedure Register;

implementation

uses mongo.Aniversary.CalendarPicker, mongo.Aniversary.ToggleSwitch,
  mongo.Aniversary.CalendarView;

procedure Register;
begin
  RegisterComponents('MongoX10 Components', [TMongoCalendarView, TMongoCalendarPicker, TMongoToggleSwitch]);
end;

end.
