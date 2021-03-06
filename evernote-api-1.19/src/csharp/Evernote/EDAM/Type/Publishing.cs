/**
 * Autogenerated by Thrift
 *
 * DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
 */
using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.IO;
using Thrift;
using Thrift.Collections;
using Thrift.Protocol;
using Thrift.Transport;
namespace Evernote.EDAM.Type
{

  [Serializable]
  public partial class Publishing : TBase
  {
    private string uri;
    private NoteSortOrder order;
    private bool ascending;
    private string publicDescription;

    public string Uri
    {
      get
      {
        return uri;
      }
      set
      {
        __isset.uri = true;
        this.uri = value;
      }
    }

    public NoteSortOrder Order
    {
      get
      {
        return order;
      }
      set
      {
        __isset.order = true;
        this.order = value;
      }
    }

    public bool Ascending
    {
      get
      {
        return ascending;
      }
      set
      {
        __isset.ascending = true;
        this.ascending = value;
      }
    }

    public string PublicDescription
    {
      get
      {
        return publicDescription;
      }
      set
      {
        __isset.publicDescription = true;
        this.publicDescription = value;
      }
    }


    public Isset __isset;
    [Serializable]
    public struct Isset {
      public bool uri;
      public bool order;
      public bool ascending;
      public bool publicDescription;
    }

    public Publishing() {
    }

    public void Read (TProtocol iprot)
    {
      TField field;
      iprot.ReadStructBegin();
      while (true)
      {
        field = iprot.ReadFieldBegin();
        if (field.Type == TType.Stop) { 
          break;
        }
        switch (field.ID)
        {
          case 1:
            if (field.Type == TType.String) {
              this.uri = iprot.ReadString();
              this.__isset.uri = true;
            } else { 
              TProtocolUtil.Skip(iprot, field.Type);
            }
            break;
          case 2:
            if (field.Type == TType.I32) {
              this.order = (NoteSortOrder)iprot.ReadI32();
              this.__isset.order = true;
            } else { 
              TProtocolUtil.Skip(iprot, field.Type);
            }
            break;
          case 3:
            if (field.Type == TType.Bool) {
              this.ascending = iprot.ReadBool();
              this.__isset.ascending = true;
            } else { 
              TProtocolUtil.Skip(iprot, field.Type);
            }
            break;
          case 4:
            if (field.Type == TType.String) {
              this.publicDescription = iprot.ReadString();
              this.__isset.publicDescription = true;
            } else { 
              TProtocolUtil.Skip(iprot, field.Type);
            }
            break;
          default: 
            TProtocolUtil.Skip(iprot, field.Type);
            break;
        }
        iprot.ReadFieldEnd();
      }
      iprot.ReadStructEnd();
    }

    public void Write(TProtocol oprot) {
      TStruct struc = new TStruct("Publishing");
      oprot.WriteStructBegin(struc);
      TField field = new TField();
      if (this.uri != null && __isset.uri) {
        field.Name = "uri";
        field.Type = TType.String;
        field.ID = 1;
        oprot.WriteFieldBegin(field);
        oprot.WriteString(this.uri);
        oprot.WriteFieldEnd();
      }
      if (__isset.order) {
        field.Name = "order";
        field.Type = TType.I32;
        field.ID = 2;
        oprot.WriteFieldBegin(field);
        oprot.WriteI32((int)this.order);
        oprot.WriteFieldEnd();
      }
      if (__isset.ascending) {
        field.Name = "ascending";
        field.Type = TType.Bool;
        field.ID = 3;
        oprot.WriteFieldBegin(field);
        oprot.WriteBool(this.ascending);
        oprot.WriteFieldEnd();
      }
      if (this.publicDescription != null && __isset.publicDescription) {
        field.Name = "publicDescription";
        field.Type = TType.String;
        field.ID = 4;
        oprot.WriteFieldBegin(field);
        oprot.WriteString(this.publicDescription);
        oprot.WriteFieldEnd();
      }
      oprot.WriteFieldStop();
      oprot.WriteStructEnd();
    }

    public override string ToString() {
      StringBuilder sb = new StringBuilder("Publishing(");
      sb.Append("uri: ");
      sb.Append(this.uri);
      sb.Append(",order: ");
      sb.Append(this.order);
      sb.Append(",ascending: ");
      sb.Append(this.ascending);
      sb.Append(",publicDescription: ");
      sb.Append(this.publicDescription);
      sb.Append(")");
      return sb.ToString();
    }

  }

}
