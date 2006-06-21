object SelectDateDialogForm: TSelectDateDialogForm
  Left = 471
  Top = 330
  Width = 215
  Height = 239
  ActiveControl = DateTimePicker
  Caption = 'Date range'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object KWizard1: TKWizard
    Left = 0
    Top = 0
    Width = 207
    Height = 212
    ActivePage = KWizardInteriorPage2
    ButtonStart.Caption = 'To &Start Page'
    ButtonStart.NumGlyphs = 1
    ButtonStart.Layout = blGlyphLeft
    ButtonStart.ModalResult = 0
    ButtonStart.Width = 85
    ButtonLast.Caption = 'To &Last Page'
    ButtonLast.NumGlyphs = 1
    ButtonLast.Layout = blGlyphLeft
    ButtonLast.ModalResult = 0
    ButtonLast.Width = 85
    ButtonBack.Caption = '< &Back'
    ButtonBack.NumGlyphs = 1
    ButtonBack.Layout = blGlyphLeft
    ButtonBack.ModalResult = 0
    ButtonBack.Width = 75
    ButtonNext.Caption = '&Next >'
    ButtonNext.NumGlyphs = 1
    ButtonNext.Layout = blGlyphLeft
    ButtonNext.ModalResult = 0
    ButtonNext.Width = 75
    ButtonFinish.Caption = '&Finish'
    ButtonFinish.NumGlyphs = 1
    ButtonFinish.Layout = blGlyphLeft
    ButtonFinish.ModalResult = 0
    ButtonFinish.Width = 75
    ButtonCancel.Caption = 'Cancel'
    ButtonCancel.NumGlyphs = 1
    ButtonCancel.Layout = blGlyphLeft
    ButtonCancel.ModalResult = 2
    ButtonCancel.Width = 75
    ButtonHelp.Caption = '&Help'
    ButtonHelp.NumGlyphs = 1
    ButtonHelp.Layout = blGlyphLeft
    ButtonHelp.ModalResult = 0
    ButtonHelp.Width = 75
    ShowRouteMap = False
    object KWizardInteriorPage2: TKWizardInteriorPage
      Header.Color = clWindow
      Header.Visible = True
      Header.ImageIndex = -1
      Header.ImageOffset = 0
      Header.ImageAlignment = iaRight
      Header.Height = 70
      Header.ParentFont = True
      Header.Title.Color = clNone
      Header.Title.Visible = True
      Header.Title.Text = 'Select date'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.AnchorPlacement = 4
      Header.Title.Indent = 0
      Header.Title.Alignment = taLeftJustify
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -16
      Header.Title.Font.Name = 'MS Sans Serif'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Visible = True
      Header.Subtitle.Text = 'Select a date to report on.'
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.AnchorPlacement = 4
      Header.Subtitle.Indent = 0
      Header.Subtitle.Alignment = taLeftJustify
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -11
      Header.Subtitle.Font.Name = 'MS Sans Serif'
      Header.Subtitle.Font.Style = []
      Header.ShowDivider = True
      Image.Alignment = iaStretch
      Image.Layout = ilStretch
      Image.Transparent = False
      Panel.Color = clBtnFace
      Panel.Visible = False
      Panel.BorderWidth = 7
      VisibleButtons = [bkBack, bkFinish, bkCancel]
      OnFinishButtonClick = KWizardInteriorPage2FinishButtonClick
      object Label1: TLabel
        Left = 23
        Top = 90
        Width = 23
        Height = 13
        Caption = 'Date'
      end
      object DateTimePicker: TDateTimePicker
        Left = 64
        Top = 88
        Width = 113
        Height = 21
        CalAlignment = dtaLeft
        Date = 37524.8952527893
        Time = 37524.8952527893
        DateFormat = dfShort
        DateMode = dmComboBox
        Kind = dtkDate
        ParseInput = False
        TabOrder = 0
      end
    end
  end
end
