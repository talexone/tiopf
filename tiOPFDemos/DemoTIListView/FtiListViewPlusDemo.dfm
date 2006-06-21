object FormListViewPlusDemo: TFormListViewPlusDemo
  Left = 367
  Top = 194
  Width = 592
  Height = 452
  Caption = ' tiListViewPlus Demo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object LVP: TtiListViewPlus
    Left = 237
    Top = 25
    Width = 347
    Height = 381
    RuntimeGenCols = False
    Align = alClient
    MultiSelect = False
    ViewStyle = vsReport
    RowSelect = True
    ApplyFilter = False
    ApplySort = False
    ListColumns = <
      item
        DisplayLabel = 'Date Data'
        FieldName = 'DateData'
        DisplayMask = 'ddd dd mmm yyyy'
        DataType = lvtkDateTime
        Derived = False
      end
      item
        DisplayLabel = 'Float Data'
        FieldName = 'FloatData'
        DisplayMask = '#,##0.00'
        DataType = lvtkCurrency
        Derived = False
      end
      item
        DisplayLabel = 'Integer Data'
        FieldName = 'IntegerData'
        DisplayMask = '#,##0'
        DataType = lvtkInt
        Derived = False
      end
      item
        DisplayLabel = 'String Data'
        FieldName = 'StringData'
        DataType = lvtkString
        Derived = False
      end>
    SortOrders = <
      item
        FieldName = 'Enter value'
        SortDirection = lvsdAscending
      end>
    AfterRefreshData = LVPAfterRefreshData
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 584
    Height = 25
    Caption = 'ToolBar1'
    Flat = True
    Images = ImageList1
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    object tbColumns: TToolButton
      Left = 0
      Top = 0
      Hint = 'Select columns'
      Caption = 'tbColumns'
      ImageIndex = 0
      OnClick = tbColumnsClick
    end
    object tbQuery: TToolButton
      Left = 23
      Top = 0
      Hint = 'Query'
      Caption = 'tbQuery'
      ImageIndex = 1
      OnClick = tbQueryClick
    end
    object tbFind: TToolButton
      Left = 46
      Top = 0
      Hint = 'Find'
      Caption = 'tbFind'
      ImageIndex = 2
      OnClick = tbFindClick
    end
    object tbSort: TToolButton
      Left = 69
      Top = 0
      Hint = 'Sort'
      Caption = 'tbSort'
      ImageIndex = 3
      OnClick = tbSortClick
    end
    object ToolButton5: TToolButton
      Left = 92
      Top = 0
      Width = 8
      Caption = 'ToolButton5'
      ImageIndex = 4
      Style = tbsSeparator
    end
    object tbClose: TToolButton
      Left = 100
      Top = 0
      Hint = 'Close'
      Caption = 'tbClose'
      ImageIndex = 4
      OnClick = tbCloseClick
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 25
    Width = 237
    Height = 381
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 2
    object Memo1: TMemo
      Left = 4
      Top = 4
      Width = 229
      Height = 372
      Anchors = [akLeft, akTop, akRight, akBottom]
      Lines.Strings = (
        'The TtiListViewPlus gives the same '
        'features for browsing a TLlist of TPersistent '
        'as the TtiListView, along with the following '
        'extra features.'
        ''
        'At design time:'
        ''
        'The same features are available as in the '
        'TtiListview.'
        ''
        'At runtime:'
        '* Define the columns to be displayed in the '
        'ListView, or to be exported.'
        ''
        '* Define a query on the available columns.'
        ''
        '* Sort the data'
        ''
        '* Find a single row'
        ''
        'Export the current view of the data '
        '(columns, filter and sort order ) to a CSV file, '
        'HTML or to the clipboard.'
        ''
        'Try setting the number of values to show '
        '(set this in the main form) to 100,000 and '
        'sorting or filtering. On my PC, this takes '
        'about 4 seconds.')
      ParentColor = True
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object SB: TStatusBar
    Left = 0
    Top = 406
    Width = 584
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object ImageList1: TImageList
    Left = 176
    Top = 6
    Bitmap = {
      494C010105000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001001000000000000018
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000010421042000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000007C00400040104200000000
      000000000000007C104200000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000007C00400040004010420000
      00000000007C0040004010420000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000007C00400040004000401042
      0000007C00400040004000401042000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000007C0040004000400040
      1042004000400040004000401042000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000007C004000400040
      0040004000400040004010420000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000007C00400040
      0040004000400040104200000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000400040
      0040004000401042000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000007C0040
      0040004000401042000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000007C00400040
      0040004000401042000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000007C004000400040
      1042004000400040104200000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000007C0040004000401042
      0000007C00400040004010420000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000007C0040004010420000
      00000000007C0040004000401042000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000007C004000000000
      000000000000007C004000400040000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000007C0040007C000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF7F
      FF7FFF7FFF7F1042FF7FFF7FFF7F000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000004000400040004000400000
      000000000000000000000000000000000000000000000000000000000000FF7F
      FF7FFF7FFF7F1042FF7FFF7FFF7F000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000004000400000000000400000
      0000000000001042000000000000000000000000000000001042104200001042
      1042104210421042104210421042000000000000000000001863186318631863
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000040000000000000
      000000001042000000001042000000000000000000000000000000000000FF7F
      FF7FFF7FFF7F1042FF7FFF7FFF7F000000000000000000001863186310420000
      0000000010420000000000000000000000000000000000001042000000000000
      10420000E07F1042000000000000000000000000000000000000004000000000
      000000000000000000000000000000000000000000000000000000000000FF7F
      FF7FFF7FFF7F1042FF7FFF7FFF7F000000000000000000001863000000000000
      0000000000000000000000000000000000000000000000001042104210421042
      104200000000E07F000000000000000000000000004000000000004000400000
      0000000000000000000000000000000000000000000000001042104200001042
      1042104210421042104210421042000000000000000000001863104200000000
      000000000000104200000000000000000000000000001042FF7F1863FF7F1863
      FF7F104200000000000000000000000000000000004000400040004000400000
      000000000000000000000000000000000000000000000000000000000000FF7F
      FF7FFF7FFF7F1042FF7FFF7FFF7F000000000000000000001042FF0300000000
      00000000000000000000000000000000000010421042FF7F1863FF7F007CFF7F
      1863FF7F10421042000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF7F
      FF7FFF7FFF7F1042FF7FFF7FFF7F0000000000000000000000000000FF030000
      FF0300000000000000000000000000000000000010421863FF7F1863007C1863
      FF7F186310420000000000000000000000000000100010001000100010001000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000001042FF7F007C007C007C007C
      007CFF7F10420000000000000000000000000000104210000000000010001042
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000010420000000000000000000000000000000000000000FF030000
      000000000000000000000000000000000000000010421863FF7F1863007C1863
      FF7F186310420000000000000000000000000000000010001000100010000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000001042000000000000000000000000000000000000000000000000
      00000000000010420000000000000000000010421042FF7F1863FF7F007CFF7F
      1863FF7F10421042000000000000000000000000000000001000100000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000001042FF7F1863FF7F1863
      FF7F104200000000000000000000000000000000000000001042104200000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000010420000
      0000000010420000000000000000000000000000000000001042104210421042
      1042000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000001042000000000000
      1042000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000CFFF00000000000087CF000000000000
      83870000000000008103000000000000C003000000000000E007000000000000
      F00F000000000000F81F000000000000F81F000000000000F01F000000000000
      E00F000000000000C107000000000000C383000000000000E7C3000000000000
      FFE3000000000000FFFF000000000000FFFFFFFFFFFDFFFFC001FFFFFFF8FFFF
      D801807FFFF183EFD801BF79FFE39BCFC001A173FFC7EF87D801A027E08FF787
      D801A38FC01FB3EFC001A78F803F83EFD801A0AF001FFFEFD801AABF001F81EF
      C001A0BF001F99EFDBDD8BBF001FC3EFDBDDF7CF001FE7EFC001F39F803FE7EF
      FFFFF83FC07FFFEFFFFFFFFFE0FFFFFF00000000000000000000000000000000
      000000000000}
  end
end
