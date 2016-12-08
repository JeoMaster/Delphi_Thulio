{ *************************************************************************** }
{ Autor: Amarildo Lacerda                                                     }
{ Data:  04/12/2016                                                           }
{ Resenha:                                                                    }
{ *************************************************************************** }
{ Licença segue a mesma estabelecida no código original determinada pelo seu  }
{ autor                                                                       }
{                                                                             }
{ *************************************************************************** }
{
  Alterações:
  + adicionado TMongoCheckBox
  + adicionado TMongoImage
}

unit mongo.VCL.Reg;

interface

uses
  System.Actions, System.Classes, System.SysUtils;

procedure Register;

implementation

uses
  mongo.VCL.MongoEdit, mongo.VCL.Actions, mongo.VCL.CheckBox, mongo.VCL.Image,
  mongo.VCL.Listbox, mongo.VCL.Combobox, mongo.VCL.RadioGroup, mongo.VCL.DateTimePicker,
  mongo.VCL.memo, mongo.VCL.RadioButton;

procedure Register;
begin
  RegisterComponents('MongoVCL Components', [TMongoEdit, TMongoRadioGroup, TMongoCheckBox, TMongoImage, TMongoMemo, TMongoListBox, TMongoCombobox,
    TMongoDateTimePicker, TMongoRadioButton]);

  RegisterActions('MongoVCL Components', [TVCLMongoInsert, TVCLMongoUpdate, TVCLMongoDelete, TVCLMongoSelect, TVCLMongoSelectEdit,
    TVCLMongoLimpar], nil);

end;

end.
