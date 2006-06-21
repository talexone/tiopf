object FormEditCompany: TFormEditCompany
  Left = 140
  Top = 128
  Width = 590
  Height = 382
  Caption = 'FormEditCompany'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  DesignSize = (
    582
    355)
  PixelsPerInch = 96
  TextHeight = 13
  object gbName: TGroupBox
    Left = 4
    Top = 4
    Width = 571
    Height = 57
    Anchors = [akLeft, akTop, akRight]
    Caption = ' Name details '
    TabOrder = 0
    DesignSize = (
      571
      57)
    object paeCompanyName: TtiPerAwareEdit
      Left = 16
      Top = 24
      Width = 543
      Height = 23
      ShowFocusRect = True
      Anchors = [akLeft, akTop, akRight]
      Constraints.MinHeight = 23
      TabOrder = 0
      Caption = 'Company &name'
      ReadOnly = False
      OnChange = paeCompanyNameChange
      MaxLength = 60
      CharCase = ecNormal
      PasswordChar = #0
    end
  end
  object tiSplitterPanel1: TtiSplitterPanel
    Left = 4
    Top = 68
    Width = 571
    Height = 512
    Aligned = alNone
    Anchors = [akLeft, akTop, akRight, akBottom]
    ColorGrabBar = 16686723
    ColorPanel = clBtnFace
    PanelStyle = spsFramed
    SplitterOrientation = spoHorizontal
    KeepSplitterPosPercent = True
    SplitterPos = 372
    SplitterPosPercent = 73
    Panel1Controls = (
      tiSplitterPanel2)
    Panel2Controls = (
      paeNotes)
    object tiSplitterPanel2: TtiSplitterPanel
      Left = 2
      Top = 2
      Width = 567
      Height = 368
      Aligned = alClient
      ColorGrabBar = 16686723
      ColorPanel = clBtnFace
      BevelInnerSubPanels = bvNone
      BevelOuterSubPanels = bvNone
      PanelStyle = spsNone
      SplitterOrientation = spoVertical
      KeepSplitterPosPercent = True
      SplitterPos = 273
      SplitterPosPercent = 48
      Panel1Controls = (
        Label1
        lvEAddress)
      Panel2Controls = (
        Label2
        lvAddress)
      object Label1: TLabel
        Left = 8
        Top = 8
        Width = 182
        Height = 13
        Caption = ' Phone, Fax, EMail  && Web Addresses '
      end
      object lvEAddress: TtiListView
        Left = 8
        Top = 24
        Width = 259
        Height = 257
        ShowFocusRect = True
        Anchors = [akLeft, akTop, akRight, akBottom]
        MultiSelect = False
        ViewStyle = vsReport
        RowSelect = True
        OnItemEdit = lvEAddressItemEdit
        OnItemInsert = lvEAddressItemInsert
        OnItemDelete = lvEAddressItemDelete
        OnFilterData = lvEAddressFilterData
        ApplyFilter = True
        ApplySort = False
        ListColumns = <
          item
            DisplayLabel = 'Address Type'
            FieldName = 'AdrsTypeAsString'
            DataType = lvtkString
            Derived = False
            Alignment = taLeftJustify
          end
          item
            DisplayLabel = 'Details'
            FieldName = 'Caption'
            DataType = lvtkString
            Derived = False
            Alignment = taLeftJustify
          end>
        SortOrders = <>
        RuntimeGenCols = False
        VisibleButtons = [tiLVBtnVisNew, tiLVBtnVisEdit, tiLVBtnVisDelete]
        CanStartDrag = False
        DesignSize = (
          259
          257)
      end
      object Label2: TLabel
        Left = 8
        Top = 8
        Width = 124
        Height = 13
        Caption = 'Postal && Street Addresses '
      end
      object lvAddress: TtiListView
        Left = 8
        Top = 25
        Width = 269
        Height = 256
        ShowFocusRect = True
        Anchors = [akLeft, akTop, akRight, akBottom]
        MultiSelect = False
        ViewStyle = vsReport
        RowSelect = True
        OnItemEdit = lvAddressItemEdit
        OnItemInsert = lvAddressItemInsert
        OnItemDelete = lvAddressItemDelete
        OnFilterData = lvEAddressFilterData
        ApplyFilter = True
        ApplySort = False
        ListColumns = <
          item
            DisplayLabel = 'Address type'
            FieldName = 'AdrsTypeAsString'
            DataType = lvtkString
            Derived = False
            Alignment = taLeftJustify
          end
          item
            DisplayLabel = 'Details'
            FieldName = 'Caption'
            DataType = lvtkString
            Derived = False
            Alignment = taLeftJustify
          end>
        SortOrders = <>
        RuntimeGenCols = False
        VisibleButtons = [tiLVBtnVisNew, tiLVBtnVisEdit, tiLVBtnVisDelete]
        CanStartDrag = False
        DesignSize = (
          269
          256)
      end
    end
    object paeNotes: TtiPerAwareMemo
      Left = 8
      Top = 6
      Width = 555
      Height = 190
      ShowFocusRect = True
      Anchors = [akLeft, akTop, akRight, akBottom]
      Constraints.MinHeight = 23
      TabOrder = 0
      LabelStyle = lsTop
      Caption = '&Notes'
      ReadOnly = False
      OnChange = paeNotesChange
      ScrollBars = ssNone
      WordWrap = True
      MaxLength = 0
    end
  end
end
