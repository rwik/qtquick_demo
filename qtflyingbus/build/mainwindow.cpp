#include "mainwindow.h"

#include <QApplication>
#include <QDeclarativeEngine>

#if defined(Q_OS_SYMBIAN)
#include <QTimer>
#include <eikenv.h>
#include <coemain.h>
#include <aknappui.h>
#endif

MainWindow::MainWindow()
  : QDeclarativeView(),
    m_isPortrait(false)
{
#if defined(Q_OS_SYMBIAN)
    setSource(QUrl::fromLocalFile("c://data/qtflyingbus/main_640_360.qml"));
#else
    setSource(QUrl::fromLocalFile("/usr/share/qtflyingbus/main_800_480.qml"));
#endif

    QObject::connect(engine(), SIGNAL(quit()), qApp, SLOT(quit()));

#if defined(Q_OS_SYMBIAN)
    QTimer::singleShot(0, this, SLOT(lockViewMode()));
#endif
}

#if defined(Q_OS_SYMBIAN)
void MainWindow::lockViewMode()
{
    CAknAppUi *aknAppUi = dynamic_cast<CAknAppUi *>(CEikonEnv::Static()->AppUi());

    if (!aknAppUi)
      return;

    if (m_isPortrait)
        aknAppUi->SetOrientationL(CAknAppUi::EAppUiOrientationPortrait);
    else
        aknAppUi->SetOrientationL(CAknAppUi::EAppUiOrientationLandscape);
}
#endif
