using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ZipProject
{
    public partial class ChatGPT_UploadFile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                // 上傳檔案
                var file = Request.Files["file"];
                if (file != null && file.ContentLength > 0)
                {
                    var fileName = Path.GetFileName(file.FileName);
                    var path = Server.MapPath("~/DownloadFolder");
                    if (!Directory.Exists(path))
                    {
                        Directory.CreateDirectory(path);
                    }

                    file.SaveAs(Path.Combine(path, fileName));
                }
            }

        }
        protected void btnUpload_Click(object sender, EventArgs e)
        {
            // 上傳檔案
            var file = fileUpload.PostedFile;
            if (file != null && file.ContentLength > 0)
            {
                var fileName = Path.GetFileName(file.FileName);
                var path = Server.MapPath("~/DownloadFolder");
                if (!Directory.Exists(path))
                {
                    Directory.CreateDirectory(path);
                }

                file.SaveAs(Path.Combine(path, fileName));
            }
        }
    }
}