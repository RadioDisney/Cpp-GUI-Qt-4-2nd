#include <QApplication>
#include <QDialog>
#include "gotocelldialog.h"

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

    // 1
//    MainWindow w;
//    w.show();

//    QLabel *label = new QLabel ("<h2><i>Hello</i> "
//                                "<font color = red>Qt!</font></h2>");
//    label->show();

//    QPushButton *button = new QPushButton ("Quit");
//    QObject::connect(button, SIGNAL(clicked()),
//                     &a, SLOT(quit()));
//    button->show();

    // 2
//    QWidget *window = new QWidget;
//    window->setWindowTitle("Enter your Age");

//    QSpinBox *spinBox = new QSpinBox;
//    QSlider *slider = new QSlider (Qt::Horizontal);
//    spinBox->setRange (0, 130);
//    slider->setRange(0, 130);

//    QObject::connect(spinBox, SIGNAL(valueChanged(int)),
//                     slider, SLOT(setValue(int)));
//    QObject::connect(slider, SIGNAL(valueChanged(int)),
//                     spinBox, SLOT(setValue(int)));

//    spinBox->setValue(35);

//    QHBoxLayout *layout = new QHBoxLayout;
//    layout->addWidget(spinBox);
//    layout->addWidget(slider);
//    window->setLayout(layout);

//    window->show();

    //3
    GoToCellDialog *dialog = new GoToCellDialog();
    dialog->show();

    return a.exec();
}
