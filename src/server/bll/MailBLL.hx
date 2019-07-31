package server.bll;

import server.utils.PHPMailer;

class MailBLL extends DatabaseBLL{

    private var _mailer:PHPMailer;

    public function sendMail(subject:String, content:String, mails:Array<String>):Void{
        var mail = new PHPMailer(true);
        mail.SMTPDebug = 2;
        mail.isSMTP();
        mail.Host = _config.mail.host;
        mail.Port = _config.mail.port;
        mail.SMTPAuth = true;
        mail.Username = _config.mail.user;
        mail.Password = _config.mail.pass;
        mail.SMTPSecure = _config.mail.security;
        mail.setFrom('nospam@tamina.io');
        for(adresse in mails){
            mail.addAddress(adresse);
        }
        mail.Subject = subject;
        mail.Body = content;
        mail.send();
    }
}
