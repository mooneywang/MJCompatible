import Foundation
import UIKit

private var app_old_exceptionHandler:(@convention(c) (NSException) -> Swift.Void)? = nil

public class AppCrashManager: NSObject {

    static func configure() {
        app_old_exceptionHandler = NSGetUncaughtExceptionHandler()
        NSSetUncaughtExceptionHandler(AppCrashManager.RecieveException)
        self.setCrashSignalHandler()
    }

    private static let RecieveException: @convention(c) (NSException) -> Swift.Void = {
        (exteption) -> Void in
        if (app_old_exceptionHandler != nil) {
            app_old_exceptionHandler!(exteption);
        }
        perform(#selector(showCrashInfo), on: Thread.main, with: nil, waitUntilDone: true)
    }

    private class func setCrashSignalHandler(){
        signal(SIGABRT, AppCrashManager.RecieveSignal)
        signal(SIGILL, AppCrashManager.RecieveSignal)
        signal(SIGSEGV, AppCrashManager.RecieveSignal)
        signal(SIGFPE, AppCrashManager.RecieveSignal)
        signal(SIGBUS, AppCrashManager.RecieveSignal)
        signal(SIGPIPE, AppCrashManager.RecieveSignal)
        signal(SIGTRAP, AppCrashManager.RecieveSignal)
    }

    private static let RecieveSignal : @convention(c) (Int32) -> Void = {
        (signal) -> Void in

        perform(#selector(showCrashInfo), on: Thread.main, with: nil, waitUntilDone: true)
    }

    /**
     エラーメッセージを表示
     */
    @objc static func showCrashInfo() {
        let message = "アプリクラッシュエラーが発生いたしました。アプリを再起動しても解消しない場合は、お問い合わせ窓口までお問い合わせください。"
        let messageDialog: UIAlertController = UIAlertController(title: "ご注意", message: message, preferredStyle: UIAlertController.Style.alert)
        messageDialog.modalPresentationStyle = .overFullScreen
        UIApplication.shared.currentViewController().present(messageDialog, animated: false, completion: nil)
        let runLoop = CFRunLoopGetCurrent()
        let allModesAO = CFRunLoopCopyAllModes(runLoop) as [AnyObject]
        guard let allModes = allModesAO as? [CFString] else {
            return
        }
        while true
        {
            for mode in allModes
            {
                CFRunLoopRunInMode(CFRunLoopMode(rawValue: mode), 0.001, false);
            }
        }
    }
}
