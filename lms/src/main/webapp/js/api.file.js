/*---------------------------------------------------------------- 
 文件名：api.file.js
 
 文件功能描述：文件管理器 前端接口
 
 需实现的接口(通过FileManageAPI.configure(e))：
    <li>相关绑定元素ID</li>
    <li>getFileManagePath()</li>
    <li>getTOC()</li>
    <li>getPlayPath()</li>
    <li>getPreviewPath()</li>
    <li>getDownloadPath()</li>
 
 //----------------------------------------------------------------*/



var FileManageAPI = new Object();

FileManageAPI.Path = getFileManagePath();

FileManageAPI.Node ={},
        
//目录结构
FileManageAPI.TOC = {
    
    /**
     * <br> 数据结构
     * <pre>
     root = {
        description:'',
        position:[],
        resource:[],
        parent:{},
        children:[{
          
            description:'',
            position:[],
         
            resource:[{
                filename: '',
                size: 0,
                postfix: '',
                status: 0,
                dir: ''
            },{...}],//递归
         
            parent:{},
            children:[{},..]//递归 
         
         },{...}]//递归
    
     }</pre>
     *
     **/
    
    DS:{
        description: '主目录',
        id: [0],
        resource: [],
        parent: null,
        children:[]
    },
    
    OM:{},getOM: function(){},
    
    set:function(){
        var ds=[];
        var om = FileManageAPI.TOC.getOM();
        
        if (om === undefined || om === null) FileManageAPI.TOC.DS.children = [];
        
        var position = [0];
        FileManageAPI.TOC.setNodesDS(om, ds, position);
        FileManageAPI.TOC.DS.children = ds;

    },
    
    setByTraversingAllFolder:function(toc){},
    
    /**
     * 
     * @param {Object Array} oNodes
     * @param {Object Array} tNodes
     * @param {Number Array} position
     * @returns {undefined}
     */
    setNodesDS: function (oNodes, tNodes, position) {
        
        if(oNodes === null){
            return [];
        }
        
        for (var i = 0; i < oNodes.length; i++) {
            tNodes.push(FileManageAPI.TOC.getNodeDS(oNodes[i], position));
            console.log('tNodes[' + i + '] is ');console.log(tNodes[i].position);

            if (oNodes[i].children !== undefined) {
                FileManageAPI.TOC.setNodesDS(oNodes[i].children, tNodes[i].children, position);
                
            };
            position.pop();
        }

    },
    
    getNodeDS: function(node, position) {
        var Node = {
            description: node.text,
            position: [],
            resource: [],
            children: [],
            parent: node.parent
        };
        
        if (node.resource !== undefined) {
            Node.resource = node.resource;
        };
        
        for(var i=0; i<=position.length; i++){
            
            if (position[i]!==undefined){
                Node.position.push(position[i]);
            } else {
                Node.position.push(node.id);
            }
            
        }position.push(node.id);
        
        
        return Node;
    },
    
    getFilesNum:function(node){},
    
    setResource: function(node, pos, cid){
        var dir = '';
        for(var i=1; i<pos.length; i++){
            dir += '/' + pos[i];
        }
        $.ajax({
            url: FileManageAPI.Path.cInfo[3] + "?scid=" + cid + '&dir=' + dir + '/',
            type: 'get',
            async: false,
            dataType: 'json',
            success: function (data) {
                node.resource= data;
                console.log(node.resource);
            },
            error: function () {
                node.resource = [];
                status = -1;
            }
        });
    }
};

//文件浏览器 HS
FileManageAPI.BrowseDB = {
    
    configure:function(e){
        
        FileManageAPI.BrowseDB.eleN = document.getElementById(e.nid);
        FileManageAPI.BrowseDB.eleP = document.getElementById(e.pid);
        FileManageAPI.BrowseDB.eleC = document.getElementById(e.cid);
        FileManageAPI.BrowseDB.eleS = document.getElementById(e.fs);
        FileManageAPI.BrowseDB.eleH = document.getElementById(e.fh);
    },
    
    set:function(){
        FileManageAPI.BrowseDB.eleN.innerHTML = '';
        FileManageAPI.BrowseDB.eleP.removeEventListener('click',function (){});
        FileManageAPI.BrowseDB.eleC.innerHTML = '';
        FileManageAPI.BrowseDB.structureMainContentByNodes(FileManageAPI.TOC.DS);
        FileManageAPI.BrowseDB.structureSideNav();
    },
    
    eleN:{},
    eleP:{},
    eleC:{},
    
    setHomeDirectory: function(eid){
        eid = document.getElementById(eid);

        eid.addEventListener('click', function () {
            FileManageAPI.updateBrowseDBByNodes(FileManageAPI.TOC.DS);
        });
    },
    
    setParentDirectory: function(pos){
        eid = FileManageAPI.BrowseDB.eleP;
        
        eid.addEventListener('click', function () {
            FileManageAPI.setNodesDSByPosition(pos);
            FileManageAPI.updateBrowseDBByNodes(FileManageAPI.Node, pos);
        });
    },
    
    setSearch: function(eid){
        eid = document.getElementById(eid);
    },
    
    structureSideNav: function(){
        var ele = FileManageAPI.BrowseDB.eleN;
        var toc = FileManageAPI.TOC.DS;
        var nav = document.createElement('ul');
        
        nav.className = 'nav';
        nav.id = 'cid-rnav-root';
        
        if (toc.children.length !== 0) {
            for (var i = 0; i < toc.children.length; i++) {
                nav.appendChild(FileManageAPI.BrowseDB.structureSideItem(toc.children[i], nav.id));
            };
        }
        ele.appendChild(nav);
        
    },
    
    structureSideItem: function(node, pid){
        
        var NavItem = document.createElement('li');
        var a = document.createElement('a');

        var Eid = 'cid-rnav';
        for (var i = 1; i < node.position.length; i++) {
            Eid += '-' + node.position[i];
            console.log(Eid);
        }

        a.className = 'waves-attach';
        a.setAttribute('data-parent', '#' + pid);
        a.addEventListener('click', function () {
            console.log(node.position);
            FileManageAPI.setNodesDSByPosition(node.position);
            FileManageAPI.updateBrowseDBByNodes(FileManageAPI.Node, node.position);
            //FileManageAPI.BrowseDB.setParentDirectory(node.parent);
        });

        if (node.children !== undefined && node.length !== 0 && node.children.length !== 0) {
            var NavUl = document.createElement('ul');
            
            NavUl.id = Eid;
            NavUl.className = 'menu-collapse collapse in';
              
            
            for (var i = 0; i < node.children.length; i++) {
                
                var _item = document.createElement('li');
                
                _item.appendChild(FileManageAPI.BrowseDB.structureSideItem(node.children[i], Eid));
                NavUl.appendChild(_item);
            }
            
            

            NavItem.appendChild(FileManageAPI.BrowseDB.getSideItemDropdown(Eid, node.description)[1]);
            //a.appendChild();
            a.appendChild(FileManageAPI.BrowseDB.getSideItemDropdown(Eid, node.description)[0]);
            NavItem.appendChild(a);
            NavItem.appendChild(NavUl);
            
        }else{
            
            a.innerHTML = node.description;
            NavItem.appendChild(a);
        }
        return NavItem;
        
    },
    
    getSideItemDropdown: function(eid, des){
        
        /**
         <a class="sn-a" href="javascript:void(0)">
            <span class="icon mg-sm-right">info</span>个人信息
-           <span class="menu-collapse-toggle waves-attach waves-effect" data-target="#collapse-profile-settings" data-toggle="collapse">
-               <div class="menu-collapse-toggle-close">
-                       <i class="icon icon-lg">close</i>
-                   </div>
-                   <div class="menu-collapse-toggle-default">
-                        <i class="icon icon-lg">add</i>
-                   </div>
-               </span>
        </a>
         * @type Element
         */
        
        var title = document.createElement('span');
        var btnWrap = document.createElement('span');
        var close = document.createElement('div');
        var iconClose = document.createElement('i');
        var open = document.createElement('div');
        var iconOpen = document.createElement('i');
        
        title.innerHTML = des;
        
        btnWrap.className = 'menu-collapse-toggle waves-attach waves-effect';
        btnWrap.setAttribute('data-target', "#" + eid);
        btnWrap.setAttribute('data-toggle', "collapse");
        
        close.className = 'menu-collapse-toggle-close';
        iconClose.className = 'icon icon-lg';
        iconClose.innerHTML = 'close',
                
        open.className = 'menu-collapse-toggle-default';
        iconOpen.className = 'icon icon-lg';
        iconOpen.innerHTML = 'add';
        
        open.appendChild(iconOpen);
        close.appendChild(iconClose);
        
        btnWrap.appendChild(open);
        btnWrap.appendChild(close);
        
        return [title,btnWrap];
    },
    
    structureMainContent: function(){
        FileManageAPI.BrowseDB.structureMainContentByNodes(FileManageAPI.TOC.DS);
    },
        
    structureMainContentByNodes: function(nodes, pos){
        var ele = FileManageAPI.BrowseDB.eleC;
        if (pos === undefined){
            nodes.resource = [];
        }
        
//        if(nodes === undefined) return;
        
        if(nodes.children.length !== 0){
            for(var i=0; i<nodes.children.length; i++){
                ele.appendChild(FileManageAPI.BrowseDB.structureFolder(nodes.children[i]));
            };
        }
        console.info(nodes.resource);
        if(nodes.resource !== undefined && nodes.resource.length !== 0){
            FileManageAPI.TOC.setResource(nodes , pos, ThisCourse.cid);
            console.info(nodes.resource);
            FileManageAPI.BrowseDB.structureFiles(nodes.resource, pos);
        }else{
            var warn = document.createElement('span');
            warn.className = 'box-small text-orange no-file';
            warn.innerHTML = '此目录下无文件';
            ele.appendChild(warn);
        }
    },
    
    structureFolder: function (node) {
        var Folder = document.createElement('div');
        var e1 = document.createElement('span');
        var e2 = document.createElement('span');
        //var e3 = document.createElement('span');
        
        Folder.addEventListener('click', function(){
            console.log(node.position);
            FileManageAPI.setNodesDSByPosition(node.position);
            FileManageAPI.updateBrowseDBByNodes(FileManageAPI.Node, node.position);
            FileManageAPI.BrowseDB.setParentDirectory(node.position);
            
        });
        
        var Eid = 'nodes';
        for(var i=1; i<node.position.length; i++){
            Eid += '-' + node.position[i];
        }
        Folder.id = Eid;
        
        e1.className = 'icon icon-4x';
        e1.innerHTML = 'folder';
        e2.className = 'folder-name';
        e2.innerHTML = node.description;
        //e3.className = 'file-num';
        //e3.innerHTML = node.number;
        
        Folder.appendChild(e1);
        Folder.appendChild(e2);
        //Folder.appendChild(e3);
        
        return Folder;
    },
    
    structureFiles: function(nodes, pos) {
        var ele = FileManageAPI.BrowseDB.eleC;
        
        for(var i=0; i<nodes.length; i++){
            var file = FileManageAPI.BrowseDB.getFileByUrls(nodes[i]);
            FileManageAPI.BrowseDB.structureFile(ele, file, pos);
        }
        return ele;
    },
    
    getFileByUrls: function(urls){
        var file = {
            name:'',
            status:'',
            type:'',
            dir:''
        };
        
        // 文件名
        file.name = urls.substr(urls.lastIndexOf("/")+1);
        
        // 文件类型
        file.type = file.name.substr(file.name.lastIndexOf(".")+1);
        console.log(file.type);
        
        // 文件拥有的事件类型
        
        // 可预览
        if(file.type === 'swf'){
            file.status = 'preview';
            
        //可播放
        }else if(file.type === 'mp4'){
            file.status = 'play';
            
        //可下载
        }else {
            file.status = 'download';
            
        }
        
        //文件对应事件类型的路径
        //预览
        if(file.status === 'download'){
            file.dir = PATH + urls;
            
        //播放
        }else if(file.status === 'preview'){
            file.dir = PATH + '/getswf?uri=' + urls;
            
        //下载
        }else if(file.status === 'play'){
            file.dir = PATH + '/getvideo?uri=' + urls;
            
        }
        
        return file;
    },
    
    structureFile: function (ele, file, pos) {
        var File = document.createElement('a');
        var icon = document.createElement('span');
        var name = document.createElement('span');
        
        File.className = 'lms-file';
        File.href = file.dir;
        
        icon.className = 'icon icon-4x ';
        //预览
        if (file.status === 'download') {
            icon.setAttribute('data-fstatus','download');

        //播放
        } else if (file.status === 'preview') {
            icon.setAttribute('data-fstatus','preview');
            File.className = 'lms-file stage-card';
            

        //下载
        } else if (file.status === 'play') {
            icon.setAttribute('data-fstatus','play');
            File.className = 'lms-file stage-card';

        }
        icon.innerHTML = 'file';
        name.className = 'file-name';
        name.innerHTML = file.name;
        
        File.appendChild(icon);
        File.appendChild(name);
        
        ele.appendChild(File);
    },

    structureMainContentByKeyword: function(str){
        
    }
};

FileManageAPI.isPositionEqual = function (pos1, pos2) {

    if (pos1.length === pos2.length) {
        for (var i = 0; i < pos1.length; i++) {
            if (pos1[i] !== pos2[i]) {
                return false;
            }
        }
        console.log("is equal !");
        return true;
    } else
        return false;
};

FileManageAPI.setNodesDSByPosition = function (pos, nodes) {

    if (nodes === undefined) {
        nodes = FileManageAPI.TOC.DS.children;
        console.log("use toc ds !");
    }

    for (var i = 0; i < nodes.length; i++) {

        //console.log(nodes[i]);
        if (FileManageAPI.isPositionEqual(nodes[i].position, pos)) {
            console.log(nodes[i]);
            FileManageAPI.Node = nodes[i];
            return true;
        }

        if (nodes[i].children !== undefined) {
            FileManageAPI.setNodesDSByPosition(pos, nodes[i].children);
        }
    }

    return {};
};

FileManageAPI.updateBrowseDBByNodes = function (nodes, pos) {
    FileManageAPI.BrowseDB.eleC.innerHTML = '';
    FileManageAPI.BrowseDB.structureMainContentByNodes(nodes, pos);
    console.log('updateBrowseDBByNodes...');
};

FileManageAPI.setNodesDSByKeyword = function (key) {

};

FileManageAPI.updateBrowseDBByKeyword = function (key) {

};

FileManageAPI.operate = {
    
    append:{},
    
    insert:{},
    
    delete:{},
    
    modify:{},
    
    find:{
        byName: function (str){},
        bySize: function (num){}
    },
    
    sort:{
        byName: function (str){},
        bySize: function (num){}
    },
    
    is:{
        exist: function (){}
    }
};

FileManageAPI.getFormattedSize = function (size) {
    if(size / 1000000 >= 1) {
        return toDecimal2(size / 1000000) + 'MB';
    } else if (size < 1000000 && size > 1000) {
        return toDecimal2(size / 1000) + 'KB';
    } else {
        return size + 'B';
    }
};

//入口函数
/**
 * 
 * @param {Object} e
 * <br>e.cid:'cid-resource-content',       
 * <br>e.hid:'cid-resource-home',
 * <br>e.pid:'cid-resource-npd', 
 * <br>e.sid:'cid-resource-search',
 * <br>e.getTOC:function(){},
 * <br>e.getPlayPath:function(){},
 * <br>e.getPreviewPath:function(){},
 * <br>e.getDownloadPath:function(){}
 * @returns {undefined}
 */
FileManageAPI.configure = function(e){
    
    FileManageAPI.BrowseDB.configure(e);
    FileManageAPI.BrowseDB.setHomeDirectory(e.hid);
    FileManageAPI.BrowseDB.setSearch(e.sid);
    FileManageAPI.TOC.getOM = e.getOM;
    FileManageAPI.getPlayPath = e.getPlayPath;
    FileManageAPI.getPreviewPath = e.getPreviewPath;
    FileManageAPI.getDownloadPath = e.getDownloadPath;
};

//功能：将浮点数四舍五入，取小数点后2位
function toDecimal(x) {
    var f = parseFloat(x);
    if (isNaN(f)) {
        return;
    }
    f = Math.round(x * 100) / 100;
    return f;
}


//强制保留2位小数，如：2，会在2后面补上00.即2.00
function toDecimal2(x) {
    var f = parseFloat(x);
    if (isNaN(f)) {
        return false;
    }
    var f = Math.round(x * 100) / 100;
    var s = f.toString();
    var rs = s.indexOf('.');
    if (rs < 0) {
        rs = s.length;
        s += '.';
    }
    while (s.length <= rs + 2) {
        s += '0';
    }
    return s;
}

function fomatFloat(src, pos) {
    return Math.round(src * Math.pow(10, pos)) / Math.pow(10, pos);
}

function getTOC(){
    return [
        {
            "id": 1,
            "state": "open",
            "text": "????",
            "attributes": "1",
            "children": [
                {
                    "id": 1,
                    "state": "open",
                    "text": "???",
                    "attributes": "2",
                    "children": [
                        {
                            "id": 1000,
                            "text": "???",
                            "state": "open",
                            "domId": "_easyui_tree_35",
                            "target": {},
                            "checked": false
                        },
                        {
                            "id": 2000,
                            "text": "???",
                            "state": "open",
                            "domId": "_easyui_tree_36",
                            "target": {},
                            "checked": false
                        }
                    ],
                    "domId": "_easyui_tree_34",
                    "target": {},
                    "checked": false
                },
                {
                    "id": 8001,
                    "attributes": "2",
                    "text": "T2",
                    "resource": [],
                    "state": "open",
                    "domId": "_easyui_tree_37",
                    "target": {},
                    "checked": false,
                    "children": [
                        {
                            "id": 8006,
                            "attributes": "3",
                            "text": "???",
                            "resource": [],
                            "state": "open",
                            "domId": "_easyui_tree_38",
                            "target": {},
                            "checked": false
                        },
                        {
                            "id": 8007,
                            "attributes": "3",
                            "text": "???",
                            "resource": [],
                            "state": "open",
                            "domId": "_easyui_tree_39",
                            "target": {},
                            "checked": false
                        },
                        {
                            "id": 8008,
                            "attributes": "3",
                            "text": "???",
                            "resource": [],
                            "state": "open",
                            "domId": "_easyui_tree_40",
                            "target": {},
                            "checked": false
                        },
                        {
                            "id": 8009,
                            "attributes": "3",
                            "text": "???",
                            "resource": [],
                            "state": "open",
                            "domId": "_easyui_tree_41",
                            "target": {},
                            "checked": false
                        },
                        {
                            "id": 8010,
                            "attributes": "3",
                            "text": "???",
                            "resource": [],
                            "state": "open",
                            "domId": "_easyui_tree_42",
                            "target": {},
                            "checked": false
                        },
                        {
                            "id": 8016,
                            "attributes": "3",
                            "text": "???",
                            "resource": [],
                            "state": "open",
                            "domId": "_easyui_tree_64"
                        }
                    ]
                },
                {
                    "id": 8002,
                    "attributes": "2",
                    "text": "???",
                    "resource": [],
                    "state": "open",
                    "domId": "_easyui_tree_43",
                    "target": {},
                    "checked": false
                },
                {
                    "id": 8003,
                    "attributes": "2",
                    "text": "???",
                    "resource": [],
                    "state": "open",
                    "domId": "_easyui_tree_44",
                    "target": {},
                    "checked": false
                },
                {
                    "id": 8004,
                    "attributes": "2",
                    "text": "???",
                    "resource": [],
                    "state": "open",
                    "domId": "_easyui_tree_45",
                    "target": {},
                    "checked": false,
                    "children": [
                        {
                            "id": 8011,
                            "attributes": "3",
                            "text": "???",
                            "resource": [],
                            "state": "open",
                            "domId": "_easyui_tree_46",
                            "target": {},
                            "checked": false
                        },
                        {
                            "id": 8012,
                            "attributes": "3",
                            "text": "???",
                            "resource": [],
                            "state": "open",
                            "domId": "_easyui_tree_47",
                            "target": {},
                            "checked": false
                        },
                        {
                            "id": 8013,
                            "attributes": "3",
                            "text": "???",
                            "resource": [],
                            "state": "open",
                            "domId": "_easyui_tree_48",
                            "target": {},
                            "checked": false
                        },
                        {
                            "id": 8014,
                            "attributes": "3",
                            "text": "???",
                            "resource": [],
                            "state": "open",
                            "domId": "_easyui_tree_49",
                            "target": {},
                            "checked": false
                        },
                        {
                            "id": 8015,
                            "attributes": "3",
                            "text": "???",
                            "resource": [],
                            "state": "open",
                            "domId": "_easyui_tree_50",
                            "target": {},
                            "checked": false
                        }
                    ]
                },
                {
                    "id": 8005,
                    "attributes": "2",
                    "text": "???",
                    "resource": [],
                    "state": "open",
                    "domId": "_easyui_tree_51",
                    "target": {},
                    "checked": false
                }
            ],
            "domId": "_easyui_tree_33",
            "target": {},
            "checked": false
        },
        {
            "id": 2,
            "state": "open",
            "text": "????",
            "attributes": "1",
            "children": [
                {
                    "id": 2,
                    "state": "open",
                    "text": "???",
                    "attributes": "2",
                    "children": [
                        {
                            "id": 3000,
                            "text": "???",
                            "state": "open",
                            "domId": "_easyui_tree_54",
                            "target": {},
                            "checked": false
                        },
                        {
                            "id": 4000,
                            "text": "???",
                            "state": "open",
                            "domId": "_easyui_tree_55",
                            "target": {},
                            "checked": false
                        }
                    ],
                    "domId": "_easyui_tree_53",
                    "target": {},
                    "checked": false
                }
            ],
            "domId": "_easyui_tree_52",
            "target": {},
            "checked": false
        },
        {
            "id": 3,
            "state": "open",
            "text": "????",
            "attributes": "1",
            "children": [
                {
                    "id": 3,
                    "state": "open",
                    "text": "???",
                    "attributes": "2",
                    "children": [
                        {
                            "id": 5000,
                            "text": "???",
                            "state": "open",
                            "domId": "_easyui_tree_58",
                            "target": {},
                            "checked": false
                        },
                        {
                            "id": 6000,
                            "text": "???",
                            "state": "open",
                            "domId": "_easyui_tree_59",
                            "target": {},
                            "checked": false
                        }
                    ],
                    "domId": "_easyui_tree_57",
                    "target": {},
                    "checked": false
                }
            ],
            "domId": "_easyui_tree_56",
            "target": {},
            "checked": false
        },
        {
            "id": 4,
            "state": "open",
            "text": "????",
            "attributes": "1",
            "children": [
                {
                    "id": 4,
                    "state": "open",
                    "text": "???",
                    "attributes": "2",
                    "children": [
                        {
                            "id": 7000,
                            "text": "???",
                            "state": "open",
                            "domId": "_easyui_tree_62",
                            "target": {},
                            "checked": false
                        },
                        {
                            "id": 8000,
                            "text": "???",
                            "state": "open",
                            "domId": "_easyui_tree_63",
                            "target": {},
                            "checked": false
                        }
                    ],
                    "domId": "_easyui_tree_61",
                    "target": {},
                    "checked": false
                }
            ],
            "domId": "_easyui_tree_60",
            "target": {},
            "checked": false
        }
    ];
}