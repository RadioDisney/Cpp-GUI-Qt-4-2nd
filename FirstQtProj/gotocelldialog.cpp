#include "gotocelldialog.h"
#include "ui_gotocelldialog.h"

GoToCellDialog::GoToCellDialog(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::GoToCellDialog)
{
    ui->setupUi(this);

    QRegExp regExp("[A-za-z][1-9][0-9]{0,2}");
    ui->lineEdit->setValidator (new QRegExpValidator(regExp, this));

    connect(ui->okButton, SIGNAL(clicked()), this, SLOT(accept()));
    connect(ui->cancelButton, SIGNAL(clicked()), this, SLOT(reject()));
}

GoToCellDialog::~GoToCellDialog()
{
    delete ui;
}

void GoToCellDialog::on_lineEdit_textChanged()
{
    ui->okButton->setEnabled(ui->lineEdit->hasAcceptableInput());
}
