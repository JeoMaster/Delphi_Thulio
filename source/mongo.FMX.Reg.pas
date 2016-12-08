unit mongo.FMX.Reg;

interface

uses
  System.Classes, System.Actions;

procedure Register;

implementation

uses
  mongo.FMX.ActionQuery, mongo.FMX.Edit, mongo.FMX.ListBox, mongo.FMX.CheckBox,
  mongo.FMX.ComboBox, mongo.FMX.GroupBox, mongo.FMX.Image, mongo.FMX.ListBoxItem;

procedure Register;
begin
     RegisterComponents('Mongo Components', [TMongoEdit, TMongoListBox,
                                             TMongoCheckBox, TMongoGroupBox,
                                             TMongoImage, TMongoListBox,
                                             TMongoListBoxItem]);

     RegisterActions('Mongo Components', [TMongoInsert,
                                          TMongoUpdate,
                                          TMongoDelete,
                                          TMongoSelect,
                                          TMongoSelectEdit,
                                          TMongoLimpar],
                                          nil);

end;

end.
