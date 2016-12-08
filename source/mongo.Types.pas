{ *************************************************************************** }
{ Data:  04/12/2016                                                           }
{ Resenha: Extraido da MongoQuery para reduzir acoplamento                    }
{ *************************************************************************** }
{ Licença segue a mesma estabelecida no código original determinada pelo seu  }
{ autor                                                                       }
{                                                                             }
{ *************************************************************************** }
{
  Alterações:
  + criado mongo.types para separar os tipos comuns; (por: Amarildo Lacerda)
}
unit mongo.Types;

interface

type
  TCampo = (Texto, Numerico, Moeda, DataHora, Booleano);
  TMongoOperacao = (moBrowse,moInsert, moUpdate, moDelete);

implementation

end.
