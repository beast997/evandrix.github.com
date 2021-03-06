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
namespace Evernote.EDAM.NoteStore
{

  [Serializable]
  public partial class AdParameters : TBase
  {
    private string clientLanguage;
    private List<AdImpressions> impressions;
    private bool supportHtml;
    private Dictionary<string, string> clientProperties;

    public string ClientLanguage
    {
      get
      {
        return clientLanguage;
      }
      set
      {
        __isset.clientLanguage = true;
        this.clientLanguage = value;
      }
    }

    public List<AdImpressions> Impressions
    {
      get
      {
        return impressions;
      }
      set
      {
        __isset.impressions = true;
        this.impressions = value;
      }
    }

    public bool SupportHtml
    {
      get
      {
        return supportHtml;
      }
      set
      {
        __isset.supportHtml = true;
        this.supportHtml = value;
      }
    }

    public Dictionary<string, string> ClientProperties
    {
      get
      {
        return clientProperties;
      }
      set
      {
        __isset.clientProperties = true;
        this.clientProperties = value;
      }
    }


    public Isset __isset;
    [Serializable]
    public struct Isset {
      public bool clientLanguage;
      public bool impressions;
      public bool supportHtml;
      public bool clientProperties;
    }

    public AdParameters() {
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
          case 2:
            if (field.Type == TType.String) {
              this.clientLanguage = iprot.ReadString();
              this.__isset.clientLanguage = true;
            } else { 
              TProtocolUtil.Skip(iprot, field.Type);
            }
            break;
          case 4:
            if (field.Type == TType.List) {
              {
                this.impressions = new List<AdImpressions>();
                TList _list86 = iprot.ReadListBegin();
                for( int _i87 = 0; _i87 < _list86.Count; ++_i87)
                {
                  AdImpressions _elem88 = new AdImpressions();
                  _elem88 = new AdImpressions();
                  _elem88.Read(iprot);
                  this.impressions.Add(_elem88);
                }
                iprot.ReadListEnd();
              }
              this.__isset.impressions = true;
            } else { 
              TProtocolUtil.Skip(iprot, field.Type);
            }
            break;
          case 5:
            if (field.Type == TType.Bool) {
              this.supportHtml = iprot.ReadBool();
              this.__isset.supportHtml = true;
            } else { 
              TProtocolUtil.Skip(iprot, field.Type);
            }
            break;
          case 6:
            if (field.Type == TType.Map) {
              {
                this.clientProperties = new Dictionary<string, string>();
                TMap _map89 = iprot.ReadMapBegin();
                for( int _i90 = 0; _i90 < _map89.Count; ++_i90)
                {
                  string _key91;
                  string _val92;
                  _key91 = iprot.ReadString();
                  _val92 = iprot.ReadString();
                  this.clientProperties[_key91] = _val92;
                }
                iprot.ReadMapEnd();
              }
              this.__isset.clientProperties = true;
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
      TStruct struc = new TStruct("AdParameters");
      oprot.WriteStructBegin(struc);
      TField field = new TField();
      if (this.clientLanguage != null && __isset.clientLanguage) {
        field.Name = "clientLanguage";
        field.Type = TType.String;
        field.ID = 2;
        oprot.WriteFieldBegin(field);
        oprot.WriteString(this.clientLanguage);
        oprot.WriteFieldEnd();
      }
      if (this.impressions != null && __isset.impressions) {
        field.Name = "impressions";
        field.Type = TType.List;
        field.ID = 4;
        oprot.WriteFieldBegin(field);
        {
          oprot.WriteListBegin(new TList(TType.Struct, this.impressions.Count));
          foreach (AdImpressions _iter93 in this.impressions)
          {
            _iter93.Write(oprot);
            oprot.WriteListEnd();
          }
        }
        oprot.WriteFieldEnd();
      }
      if (__isset.supportHtml) {
        field.Name = "supportHtml";
        field.Type = TType.Bool;
        field.ID = 5;
        oprot.WriteFieldBegin(field);
        oprot.WriteBool(this.supportHtml);
        oprot.WriteFieldEnd();
      }
      if (this.clientProperties != null && __isset.clientProperties) {
        field.Name = "clientProperties";
        field.Type = TType.Map;
        field.ID = 6;
        oprot.WriteFieldBegin(field);
        {
          oprot.WriteMapBegin(new TMap(TType.String, TType.String, this.clientProperties.Count));
          foreach (string _iter94 in this.clientProperties.Keys)
          {
            oprot.WriteString(_iter94);
            oprot.WriteString(this.clientProperties[_iter94]);
            oprot.WriteMapEnd();
          }
        }
        oprot.WriteFieldEnd();
      }
      oprot.WriteFieldStop();
      oprot.WriteStructEnd();
    }

    public override string ToString() {
      StringBuilder sb = new StringBuilder("AdParameters(");
      sb.Append("clientLanguage: ");
      sb.Append(this.clientLanguage);
      sb.Append(",impressions: ");
      sb.Append(this.impressions);
      sb.Append(",supportHtml: ");
      sb.Append(this.supportHtml);
      sb.Append(",clientProperties: ");
      sb.Append(this.clientProperties);
      sb.Append(")");
      return sb.ToString();
    }

  }

}
