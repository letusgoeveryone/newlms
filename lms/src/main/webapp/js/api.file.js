/*---------------------------------------------------------------- 
 文件名：api.file.js
 
 文件功能描述：文件管理器 前端接口
 
 需实现的接口(通过FileManageAPI.init())：
    <li>getFileManagePath()</li>
    <li>getTOC()</li>
    <li>getPlayPath()</li>
    <li>getPreviewPath()</li>
    <li>getDownloadPath()</li>
 
 初始化函数(文件浏览器|学生端):
     FileManageAPI.init();

 更新函数(文件浏览器|学生端):
     FileManageAPI.update();
 
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
    OM:{},
    getOM:function(){},
    
    set:function(){
        var ds=[];
        var om = FileManageAPI.TOC.getOM();
        
        if (om === undefined || om === null) FileManageAPI.TOC.DS.children = [];
        
        var position = [0];
        FileManageAPI.TOC.setNodesDS(om, ds, position);
        FileManageAPI.TOC.DS.children = ds;

    },
    
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
    
    countFilesNum:function(node){},
    
    updataDSByTraversingAllFolder:function(toc){}
};

//文件浏览器 HS
FileManageAPI.BrowserHS = {
    
    init:function(){
        FileManageAPI.BrowserHS.eleN.innerHTML = '';
        FileManageAPI.BrowserHS.eleP.removeEventListener('click',function (){});
        FileManageAPI.BrowserHS.eleC.innerHTML = '';
        FileManageAPI.BrowserHS.structureMainContentByNodes(FileManageAPI.TOC.DS);
        FileManageAPI.BrowserHS.structureSideNav();
    },
    
    eleN:{},
    eleP:{},
    eleC:{},
    
    setEleN: function (eid) {
        FileManageAPI.BrowserHS.eleN = document.getElementById(eid);
    },
    
    setEleP: function (eid) {
        FileManageAPI.BrowserHS.eleP = document.getElementById(eid);
    },
    
    setEleC: function(eid){
        FileManageAPI.BrowserHS.eleC = document.getElementById(eid);
    },
    
    setHomeDirectory: function(eid){
        eid = document.getElementById(eid);

        eid.addEventListener('click', function () {
            FileManageAPI.updateBrowserHSByNodes(FileManageAPI.TOC.DS);
        });
    },
    
    setParentDirectory: function(pos){
        eid = FileManageAPI.BrowserHS.eleP;
        
        eid.addEventListener('click', function () {
            FileManageAPI.setNodesDSByPosition(pos);
            FileManageAPI.updateBrowserHSByNodes(FileManageAPI.Node);
        });
    },
    
    setSearch: function(eid){
        eid = document.getElementById(eid);
    },
    
    structureSideNav: function(){
        var ele = FileManageAPI.BrowserHS.eleN;
        var toc = FileManageAPI.TOC.DS;
        var nav = document.createElement('ul');
        
        nav.className = 'nav';
        nav.id = 'cid-rnav-root';
        
        if (toc.children.length !== 0) {
            for (var i = 0; i < toc.children.length; i++) {
                nav.appendChild(FileManageAPI.BrowserHS.structureSideItem(toc.children[i], nav.id));
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
        a.innerHTML = node.description;
        a.setAttribute('data-parent', '#' + pid);
        a.addEventListener('click', function () {
            console.log(node.position);
            FileManageAPI.setNodesDSByPosition(node.position);
            FileManageAPI.updateBrowserHSByNodes(FileManageAPI.Node);
            //FileManageAPI.BrowserHS.setParentDirectory(node.parent);
        });

        if (node.children !== undefined) {
            var NavUl = document.createElement('ul');
            
            NavUl.id = Eid;
            NavUl.className = 'menu-collapse collapse';
						
            a.setAttribute('href', '#' + Eid);
            a.setAttribute('data-toggle', 'collapse');
            
            for (var i = 0; i < node.children.length; i++) {
                
                var _item = document.createElement('li');
                
                _item.appendChild(FileManageAPI.BrowserHS.structureSideItem(node.children[i], Eid));
                NavUl.appendChild(_item);
            }
            
            
            NavItem.appendChild(a);
            NavItem.appendChild(NavUl);
            
        }else{
            
            NavItem.appendChild(a);
        }
        return NavItem;
        
    },
        
    structureMainContentByNodes: function(nodes){
        var ele = FileManageAPI.BrowserHS.eleC;
        
//        if(nodes === undefined) return;
        
        if(nodes.children.length !== 0){
            for(var i=0; i<nodes.children.length; i++){
                ele.appendChild(FileManageAPI.BrowserHS.structureFolder(nodes.children[i]));
            };
        }
        
        if(nodes.resource !== undefined){
            for(var i=0; i<nodes.resource.length; i++){
                ele.appendChild(FileManageAPI.BrowserHS.structureFiles(nodes.resource));
            };
        }
    },
    
    structureFolder: function (node) {
        var Folder = document.createElement('div');
        var e1 = document.createElement('span');
        var e2 = document.createElement('span');
        var e3 = document.createElement('span');
        
        Folder.addEventListener('click', function(){
            console.log(node.position);
            FileManageAPI.setNodesDSByPosition(node.position);
            FileManageAPI.updateBrowserHSByNodes(FileManageAPI.Node);
            FileManageAPI.BrowserHS.setParentDirectory(node.position);
            
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
        e3.className = 'file-num';
        e3.innerHTML = node.number;
        
        Folder.appendChild(e1);
        Folder.appendChild(e2);
        Folder.appendChild(e3);
        
        return Folder;
    },
    
    structureFiles: function(nodes) {
        var table = document.createElement('table');
        table.className = 'table table-responsive table-filelist';
        
        FileManageAPI.BrowserHS.structureFilesHeader(table);
        
        for(var i=0; i<nodes.length; i++){
            FileManageAPI.BrowserHS.structureFile(table,nodes[i]);
        }
        return table;
    },
    
    structureFilesHeader: function(node){
        
        var header = node.createTHead();
        var row = header.insertRow();
        var filename = row.insertCell();
        var filesize = row.insertCell();
        var filedownload = row.insertCell();
        var filemethod = row.insertCell();
        
        header.className = '';
        
        filename.innerHTML = '文件名';
        filesize.innerHTML = '大小';
        filedownload.innerHTML = '下载';
        filemethod.innerHTML = '其他';
        
    },
    
    structureFile: function(node, file){
        
        var File = node.insertRow();
        var name = File.insertCell();
        var size = File.insertCell();
        var download = File.insertCell();
        var method = File.insertCell();
        
        var e1 = document.createElement('a');
        e1.className = 'btn btn-flat btn-brand';
        e1.setAttribute('target','_blank');
        
        var e2 = document.createElement('a');
        e2.className = 'btn btn-flat btn-red stage-card';
        
        name.innerHTML = file.name;
        name.className = 'text-indianred text-blod';
        size.innerHTML = FileManageAPI.getFormattedSize(file.size);
        
        
        if(file.status === 'normal'){
            e1.setAttribute('href',FileManageAPI.getDownloadPath(file.position));
            e1.innerHTML = '下载';
            e2.innerHTML = '';
            
        }else if(file.status === 'preview'){
            
            e1.setAttribute('href',FileManageAPI.getDownloadPath(file.position));
            e1.innerHTML = '下载';
            e2.setAttribute('href',FileManageAPI.getPreviewPath(file.position));
            e2.innerHTML = '预览';
            
        }else if(file.status === 'play'){
            e1.setAttribute('href',FileManageAPI.getDownloadPath(file.position));
            e1.innerHTML = '下载';
            e2.setAttribute('href',FileManageAPI.getPlayPath(file.position));
            e2.innerHTML = '播放';
        }
        download.appendChild(e1);
        method.appendChild(e2);
        
        //
        File.appendChild(name);
        File.appendChild(size);
        File.appendChild(download);
        File.appendChild(method);
        
        node.appendChild(File);
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

FileManageAPI.updateBrowserHSByNodes = function (nodes) {
    FileManageAPI.BrowserHS.eleC.innerHTML = '';
    FileManageAPI.BrowserHS.structureMainContentByNodes(nodes);
    console.log('updateBrowserHSByNodes...');
};

FileManageAPI.setNodesDSByKeyword = function (key) {

};

FileManageAPI.updateBrowserHSByKeyword = function (key) {

};

FileManageAPI.method = {
    
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
    
    FileManageAPI.BrowserHS.setEleN(e.nid);
    FileManageAPI.BrowserHS.setEleP(e.pid);
    FileManageAPI.BrowserHS.setEleC(e.cid);
    FileManageAPI.BrowserHS.setHomeDirectory(e.hid);
    FileManageAPI.BrowserHS.setSearch(e.sid);
    FileManageAPI.TOC.getOM = e.getOM;
    FileManageAPI.getPlayPath = e.getPlayPath;
    FileManageAPI.getPreviewPath = e.getPreviewPath;
    FileManageAPI.getDownloadPath = e.getDownloadPath;
};

FileManageAPI.update= function(){
    FileManageAPI.BrowserHS.init();
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