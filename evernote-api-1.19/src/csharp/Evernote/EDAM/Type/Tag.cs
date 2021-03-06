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
  public partial class Tag : TBase
  {
    private string guid;
    private string name;
    private string parentGuid;
    private int updateSequenceNum;

    public string Guid
    {
      get
      {
        return guid;
      }
      set
      {
        __isset.guid = true;
        this.guid = value;
      }
    }

    public string Name
    {
      get
      {
        return name;
      }
      set
      {
        __isset.name = true;
        this.name = value;
      }
    }

    public string ParentGuid
    {
      get
      {
        return parentGuid;
      }
      set
      {
        __isset.parentGuid = true;
        this.parentGuid = value;
      }
    }

    public int UpdateSequenceNum
    {
      get
      {
        return updateSequenceNum;
      }
      set
      {
        __isset.updateSequenceNum = true;
        this.updateSequenceNum = value;
      }
    }


    public Isset __isset;
    [Serializable]
    public struct Isset {
      public bool guid;
      public bool name;
      public bool parentGuid;
      public bool updateSequenceNum;
    }

    public Tag() {
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
              this.guid = iprot.ReadString();
              this.__isset.guid = true;
            } else { 
              TProtocolUtil.Skip(iprot, field.Type);
            }
            break;
          case 2:
            if (field.Type == TType.String) {
              this.name = iprot.ReadString();
              this.__isset.name = true;
            } else { 
              TProtocolUtil.Skip(iprot, field.Type);
            }
            break;
          case 3:
            if (field.Type == TType.String) {
              this.parentGuid = iprot.ReadString();
              this.__isset.parentGuid = true;
            } else { 
              TProtocolUtil.Skip(iprot, field.Type);
            }
            break;
          case 4:
            if (field.Type == TType.I32) {
              this.updateSequenceNum = iprot.ReadI32();
              this.__isset.updateSequenceNum = true;
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
      TStruct struc = new TStruct("Tag");
      oprot.WriteStructBegin(struc);
      TField field = new TField();
      if (this.guid != null && __isset.guid) {
        field.Name = "guid";
        field.Type = TType.String;
        field.ID = 1;
        oprot.WriteFieldBegin(field);
        oprot.WriteString(this.guid);
        oprot.WriteFieldEnd();
      }
      if (this.name != null && __isset.name) {
        field.Name = "name";
        field.Type = TType.String;
        field.ID = 2;
        oprot.WriteFieldBegin(field);
        oprot.WriteString(this.name);
        oprot.WriteFieldEnd();
      }
      if (this.parentGuid != null && __isset.parentGuid) {
        field.Name = "parentGuid";
        field.Type = TType.String;
        field.ID = 3;
        oprot.WriteFieldBegin(field);
        oprot.WriteString(this.parentGuid);
        oprot.WriteFieldEnd();
      }
      if (__isset.updateSequenceNum) {
        field.Name = "updateSequenceNum";
        field.Type = TType.I32;
        field.ID = 4;
        oprot.WriteFieldBegin(field);
        oprot.WriteI32(this.updateSequenceNum);
        oprot.WriteFieldEnd();
      }
      oprot.WriteFieldStop();
      oprot.WriteStructEnd();
    }

    public override string ToString() {
      StringBuilder sb = new StringBuilder("Tag(");
      sb.Append("guid: ");
      sb.Append(this.guid);
      sb.Append(",name: ");
      sb.Append(this.name);
      sb.Append(",parentGuid: ");
      sb.Append(this.parentGuid);
      sb.Append(",updateSequenceNum: ");
      sb.Append(this.updateSequenceNum);
      sb.Append(")");
      return sb.ToString();
    }

  }

}
