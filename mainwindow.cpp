#include "mainwindow.h"
#include "ui_mainwindow.h"

extern "C" double parse_expr(char * expr);

extern "C" {
    typedef struct yy_buffer_state * YY_BUFFER_STATE;
    extern YY_BUFFER_STATE yy_scan_string(char * str);
    extern void yy_delete_buffer(YY_BUFFER_STATE buffer);
}

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    // 这里一堆的信号和槽
    // 只是单纯的输入内容。
    connect(ui->btn_0, SIGNAL(clicked()), this, SLOT(input_content()));
    connect(ui->btn_1, SIGNAL(clicked()), this, SLOT(input_content()));
    connect(ui->btn_2, SIGNAL(clicked()), this, SLOT(input_content()));
    connect(ui->btn_3, SIGNAL(clicked()), this, SLOT(input_content()));
    connect(ui->btn_4, SIGNAL(clicked()), this, SLOT(input_content()));
    connect(ui->btn_5, SIGNAL(clicked()), this, SLOT(input_content()));
    connect(ui->btn_6, SIGNAL(clicked()), this, SLOT(input_content()));
    connect(ui->btn_7, SIGNAL(clicked()), this, SLOT(input_content()));
    connect(ui->btn_8, SIGNAL(clicked()), this, SLOT(input_content()));
    connect(ui->btn_9, SIGNAL(clicked()), this, SLOT(input_content()));
    connect(ui->btn_dot, SIGNAL(clicked()), this, SLOT(input_content()));
    connect(ui->btn_left_bracket, SIGNAL(clicked()), this, SLOT(input_content()));
    connect(ui->btn_right_bracket, SIGNAL(clicked()), this, SLOT(input_content()));
    connect(ui->btn_mul, SIGNAL(clicked()), this, SLOT(input_content()));
    connect(ui->btn_div, SIGNAL(clicked()), this, SLOT(input_content()));
    connect(ui->btn_add, SIGNAL(clicked()), this, SLOT(input_content()));
    connect(ui->btn_sub, SIGNAL(clicked()), this, SLOT(input_content()));

    // 计算的
    connect(ui->btn_calu, SIGNAL(clicked()), this, SLOT(calu()));

}
MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::input_content(){
    // 首先取得这个按钮的内容,这里是取得指针
    QPushButton * btn = (QPushButton*)sender();
    QString text = btn->text(); // 取得内容。
    ui->txt_content->insertPlainText(text); // 在当前位置插入。

}


void MainWindow::calu(){
    // 这个首先取得字符串，然后运算，最后将结果显示
    char * ch;
    // 注意，要追加一个回车。
    QByteArray ba = ui->txt_content->toPlainText().arg("\n").toLatin1().append("\n");
    ch = ba.data();
    //
    double result = parse_expr(ch);
    //
    ui->txt_result->setText(QString::number(result));




}

void MainWindow::on_btn_calu_clicked()
{

}

